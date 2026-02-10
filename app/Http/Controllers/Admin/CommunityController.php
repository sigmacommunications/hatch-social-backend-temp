<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Community;
use App\Models\CommunityTeam;
use App\Models\Subscription;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class CommunityController extends Controller
{
    public function index()
    {
        $data['communities'] = Community::all();
        return view('admin.community.index',$data);
    }

    public function create(Request $request)
    {
        $community = new Community([
            'status' => 'active',
            'privacy' => 'public',
            'membership_cost' => 'no',
        ]);

        return view('admin.community.create', [
            'community' => $community,
            'profileId' => $request->query('profile_id'),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $this->validateCommunity($request);

        if ($request->hasFile('image')) {
            $validated['image'] = $this->uploadImage($request);
        }

        $community = Community::create($validated);

        return $this->redirectAfterSave($request, $community, 'Community created successfully.');
    }

    public function show(Community $nest)
    {
        $data['owner'] = CommunityTeam::where('role','owner')->where('community_id',$nest->id)->get();
        $data['admin'] = CommunityTeam::where('role','admin')->where('community_id',$nest->id)->get();
        $data['moderator'] = CommunityTeam::where('role','moderator')->where('community_id',$nest->id)->get();
        $data['member'] = CommunityTeam::where('role','member')->where('community_id',$nest->id)->get();
        $data['payments'] = Subscription::where('community_id',$nest->id)->get();
        $data['community'] = $nest;
        return view('admin.community.detail',$data);
    }

    public function edit(Community $nest, Request $request)
    {
        return view('admin.community.edit', [
            'community' => $nest,
            'profileId' => $request->query('profile_id'),
        ]);
    }

    public function update(Request $request, Community $nest)
    {
        $validated = $this->validateCommunity($request, $nest->id);

        if ($request->hasFile('image')) {
            $this->deleteImage($nest);
            $validated['image'] = $this->uploadImage($request);
        }

        $nest->update($validated);

        return $this->redirectAfterSave($request, $nest, 'Community updated successfully.');
    }

    public function destroy(Request $request, Community $nest)
    {
        $this->deleteImage($nest);
        $nest->delete();

        $route = $request->query('profile_id')
            ? route('profiles.show', $request->query('profile_id'))
            : route('nests.index');

        return redirect($route)->with('success', 'Community deleted successfully.');
    }

    protected function validateCommunity(Request $request, ?int $communityId = null): array
    {
        return $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'privacy' => 'nullable|string|max:50',
            'joining_cost' => 'nullable|numeric|min:0',
            'membership_cost' => 'nullable|string|max:50',
            'app_service_charges' => 'nullable|numeric|min:0',
            'status' => 'nullable|string|max:50',
            'profile_id' => 'nullable|exists:profiles,id',
            'image' => 'nullable|image|max:2048',
        ]);
    }

    protected function uploadImage(Request $request): string
    {
        $path = $request->file('image')->store('communities', 'public');
        return 'storage/' . $path;
    }

    protected function deleteImage(?Community $community): void
    {
        $oldPath = $community?->image;
        $relativeOld = $oldPath && Str::startsWith($oldPath, 'storage/') ? Str::after($oldPath, 'storage/') : $oldPath;
        if ($relativeOld && Storage::disk('public')->exists($relativeOld)) {
            Storage::disk('public')->delete($relativeOld);
        }
    }

    protected function redirectAfterSave(Request $request, Community $community, string $message)
    {
        $route = $request->query('profile_id')
            ? route('profiles.show', $request->query('profile_id'))
            : route('nests.index');

        return redirect($route)->with('success', $message);
    }
}
