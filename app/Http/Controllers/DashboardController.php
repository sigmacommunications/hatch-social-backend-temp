<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AdminInfo;
use Validator;
use App\Models\User;
use App\Models\Community;
use App\Models\Profile;
use App\Models\Webmessage;

class DashboardController extends Controller
{
   public function dashboard()
   {
    return view('admin.dashboard');
   }


	public function chat_list()
   	{
		$profiles = Community::where('membership_cost','yes')->pluck('profile_id');
		$data['profiles'] = Profile::withCount(['unreadMessages as unread_count'])
			->whereIn('id', $profiles)
			->orderBy('name')
			->get();

		$data['allProfiles'] = Profile::select('id', 'name', 'type', 'photo')
			->orderBy('name')
			->get();

		// $data['messageStats'] = [
		// 	'total' => Webmessage::count(),
		// 	'unread' => Webmessage::where('is_read', 0)->count(),
		// 	'today' => Webmessage::whereDate('created_at', now()->toDateString())->count(),
		// 	'unique_senders' => Webmessage::distinct('sender_id')->count('sender_id'),
		// ];

	    return view('admin.chat', $data);
   	}

	public function profile_chat_list($id)
   	{

		$data['user'] = User::withCount([
				'unreadMessages as unread_count' => function($query) use ($id) {
					$query->where('receiver_id', $id); // Yahan URL se $id use kar rahe hain
				}
			])->where('role','admin')->first();
    	return view('admin.profile-chat',$data);
   	}

   public function admin_info()
   {
      $admin =AdminInfo::first();
      return view('admin.info',compact('admin'));
   }

	public function negotiators_list()
   {
    $users = User::where('email', '!=', 'admin@gmail.com')->get();

    // dd($users);
      return view('admin.negotiator_list',compact('users'));
   }

   public function admin_info_post(Request $request)
   {
      try{
         $validator = Validator::make($request->all(),[
             'official_email' => 'required|email',
             'phone'=>'required|numeric'
         ]);
         if($validator->fails())
         {
             return redirect()->back()->with(['error'=>$validator->errors()->first()]);
         }
         if($request->id != null)
         {
            $admin =AdminInfo::first();
            $admin->official_email = $request->official_email;
            $admin->phone = $request->phone;
            $admin->save();
         }else{
            $admin =new AdminInfo();
            $admin->official_email = $request->official_email;
            $admin->phone = $request->phone;
            $admin->save();
         }
         return redirect()->back()->with(['success'=>'Record Created Successfully']);

      }catch(\Exception $e){
            return redirect()->back()->with(['error'=>$e->getMessage()]);
        }
   }
}
