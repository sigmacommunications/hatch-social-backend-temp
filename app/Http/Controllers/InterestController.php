<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\Interests;
class InterestController extends Controller
{
	public function index()
    {
		$data['interests'] = Interests::get();
        return view('admin.interests.index',$data);
    }
	
    public function create()
    {
        return view('admin.interests.create');
    }
	
	public function edit($id)
    {
		$data['interest'] = Interests::findorfail($id);
        return view('admin.interests.edit',$data);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'type' => 'required|string|in:biz,invest,social,traders',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048'
        ]);

        $name = $request->input('name');
        $type = $request->input('type');
        $file = $request->file('image');
        $fileName = md5($file->getClientOriginalName() . time()) . '.' . $file->getClientOriginalExtension();
        $filePath = 'uploads/user/interests/' . $fileName;

        // Move the file to the desired directory
        $file->move(public_path('uploads/user/interests/'), $fileName);

        // Here you can store the file path and type in the database if needed.
        // Example:
        \DB::table('interests')->insert([
            'name' => $name,
            'type' => $type,
            'image' => $filePath,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return back()->with('success', 'Images uploaded successfully!');
    }
	
	public function update(Request $request, $id)
	{
		$request->validate([
			'name' => 'required|string|max:255',
			'type' => 'required|string|in:biz,invest,social,traders',
			'image' => 'nullable|image'
		]);

		$interest = \DB::table('interests')->where('id', $id)->first();

		if (!$interest) {
			return back()->with('error', 'Interest not found.');
		}

		$name = $request->input('name');
		$type = $request->input('type');
		$filePath = $interest->image;

		if ($request->hasFile('image')) {
			// Delete old image if exists
			if (file_exists(public_path($interest->image))) {
				unlink(public_path($interest->image));
			}

			$file = $request->file('image');
			$fileName = md5($file->getClientOriginalName() . time()) . '.' . $file->getClientOriginalExtension();
			$filePath = 'uploads/user/interests/' . $fileName;

			// Move new file
			$file->move(public_path('uploads/user/interests/'), $fileName);
		}

		// Update in database
		\DB::table('interests')->where('id', $id)->update([
			'name' => $name,
			'type' => $type,
			'image' => $filePath,
			'updated_at' => now(),
		]);

		return back()->with('success', 'Interest updated successfully!');
	}
}
