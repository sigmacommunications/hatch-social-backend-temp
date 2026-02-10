<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Interests;
use Illuminate\Support\Facades\Storage;

class InterestController extends Controller
{
    public function index()
    {
        $data['interests'] = Interests::all();
        return view('admin.interests.index', $data);
    }

    public function create()
    {
        return view('admin.interests.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'type' => 'required|string',
            'image' => 'nullable|image|mimes:jpg,png,jpeg',
        ]);

        $data = $request->only(['name', 'type']);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('interests', 'public');
            $data['image'] = $imagePath;
        }

        Interests::create($data);

        return redirect()->to('interests')->with('success', 'Interest Create Success');
    }

    // public function storee(Request $request)
    // {
    //     $request->validate([
    //         'name' => 'required|string',
    //         'type' => 'required|string',
    //         'image' => 'nullable|image|mimes:jpg,png,jpeg',
    //     ]);

    //     $imagePath = null;
    //     if ($request->hasFile('image')) {
    //         $file = request()->file('image');
    //         $fileName = md5($file->getClientOriginalName() . time()) . '.' . $file->getClientOriginalExtension();
    //         $file->move('uploads/interest/', $fileName);
    //         $imagePath = 'uploads/interest/' . $fileName;
    //     }

    //     Interests::create([
    //         'name' => $request->name,
    //         'type' => $request->type,
    //         'image' => $imagePath
    //     ]);

    //     return redirect()->to('interests')->with('success', 'Interest Add Success');
    // }

    public function edit($id)
    {
        $data['interest'] = Interests::find($id);
        return view('admin.interests.edit', $data);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name'  => 'required|string',
            'type'  => 'required|string',
            'image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        $interest = Interests::findOrFail($id);

        if ($request->hasFile('image')) {

            // ✅ DEBUG (1 dafa dekh lo)
            // dd($interest->image);

            // 🔥 OLD IMAGE DELETE (FIXED)
            if (!empty($interest->image)) {
                $oldPath = str_replace('storage/', '', $interest->image);

                if (Storage::disk('public')->exists($oldPath)) {
                    Storage::disk('public')->delete($oldPath);
                }
            }

            // ✅ NEW IMAGE SAVE
            $imagePath = $request->file('image')->store('interests', 'public');
            $interest->image = $imagePath;
        }

        $interest->update([
            'name' => $request->name,
            'type' => $request->type,
        ]);

        return redirect()->route('interests.index')
            ->with('success', 'Interest updated successfully');
    }

    public function destroy($id)
    {
        try {
            $interest = Interests::findOrFail($id);

            // Delete image if exists
            if (!empty($interest->image)) {
                // یقینی بنائیں کہ image path درست ہے
                $imagePath = $interest->image;
                if (strpos($imagePath, 'storage/') === 0) {
                    $imagePath = str_replace('storage/', '', $imagePath);
                }

                if (Storage::disk('public')->exists($imagePath)) {
                    Storage::disk('public')->delete($imagePath);
                }
            }

            $interest->delete();

            if (request()->ajax() || request()->wantsJson()) {
                return response()->json([
                    'success' => true,
                    'message' => 'Interest deleted successfully'
                ]);
            }

            return redirect()
                ->route('interests.index')
                ->with('success', 'Interest deleted successfully');
        } catch (\Exception $e) {
            if (request()->ajax() || request()->wantsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to delete interest: ' . $e->getMessage()
                ], 500);
            }

            return redirect()
                ->route('interests.index')
                ->with('error', 'Failed to delete interest');
        }
    }
}
