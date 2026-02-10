<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Event;
use App\Models\EventJoin;
use App\Models\EventImage;
use Validator;
use Auth;
use App\Notifications\GeneralNotification;
use App\Services\FirebaseService;
use App\Models\Community;
use App\Models\CommunityTeam;
use App\Models\Profile;

class EventController extends BaseController
{
	
	protected $firebaseService;
	
	public function __construct(FirebaseService $firebaseService)
    {
		$this->firebaseService = $firebaseService;
    }
    public function index()
    {
        
    }

    public function event_join(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'profile_id' => 'required|exists:profiles,id',
                'event_id' => 'required|exists:events,id',
            ]);  
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first());
            }

            $input['profile_id'] = $request->profile_id;
            $input['event_id'] = $request->event_id;
            $data = EventJoin::create($input);
            
            return response()->json(['success'=>true,'message'=>'Event Request Successfully']);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'profile_id'    => 'required',
                'community_id'  => 'required',
                'title'         => 'required|string',
                'description'   => 'required',			
                'date'          => 'required',			
                'time'          => 'required',			
            ]);  
            
            if ($validator->fails()) {
                return $this->sendError($validator->errors()->first());
            }

            $input['profile_id']    = $request->profile_id;
            $input['community_id']  = $request->community_id;
            $input['title']         = $request->title;
            $input['description']   = $request->description;
            $input['date']          = $request->date;
            $input['time']          = $request->time;
            $input['address']       = $request->address;

            // Community members excluding creator
            $profiles = CommunityTeam::where('community_id', $request->community_id)
                        ->where('profile_id', '!=', $request->profile_id)
                        ->pluck('profile_id');

            $community = Community::find($request->community_id);
            $creator   = Profile::find($request->profile_id); // Event creator

            foreach ($profiles as $profile_id) {
                $user = Profile::find($profile_id); // Member

                if ($user) {
                    // Message without profile name
                    $body  = "UpComing New event in " . $community->title . " " . $request->title;
                    $title = "New Event";

                    // ✅ Firebase Notification
                    if (!empty($user->device_token)) {
                        $this->firebaseService->sendNotification($user->device_token, $title, $body);
                    }

                    // ✅ Laravel Notification (DB + Pusher)
                    $user->notify(new GeneralNotification([
                        'profile_id'    => $creator->id,              // receiver
                        'type'          => 'community event',
                        'community_id'  => $request->community_id,
                        'sender_id'     => $user->id,           // creator as sender
                        'message'       => $body,                  // clean message
                    ]));
                }
            }

            // Save event
            $data = Event::create($input);

            // Save event images
            if ($request->hasFile('image')) {
                $uploadedFiles = $request->file('image');
                foreach ($uploadedFiles as $file) {
                    $fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
                    $file->move('uploads/event/', $fileName);
                    EventImage::create([
                        'event_id' => $data->id,
                        'name'     => 'uploads/event/' . $fileName
                    ]);
                }
            }

            return response()->json(['success' => true, 'message' => 'Event Created Successfully']);
        } 
        catch (\Exception $e) {
            return $this->sendError($e->getMessage());    
        }
    }



    public function show($id)
    {
        $post = Event::with('images','user_info','join')->where('community_id',$id)
			->orwhereHas('join', function($query) {
				$query->where('profile_id', request('profile_id')); // Replace with your condition
			})->get();
        return response()->json(['success'=>true,'message'=>'Event Lists','event_list'=>$post],200);
    }

    public function edit($id)
    {
        
    }

    public function update(Request $request, $id)
    {
        try {
            $validator = Validator::make($request->all(), [
                'profile_id' => 'required',
                'community_id' => 'required',
                'title' => 'required|string',
                'description' => 'required',
                'date' => 'required',
                'time' => 'required',
            ]);

            if ($validator->fails()) {
                return $this->sendError($validator->errors()->first());
            }

            $event = Event::find($id);
            if (!$event) {
                return response()->json(['success' => false, 'message' => 'Event not found'], 404);
            }

            $event->update([
                'profile_id' => $request->profile_id,
                'community_id' => $request->community_id,
                'title' => $request->title,
                'description' => $request->description,
                'date' => $request->date,
				'address' => $request->address,
                'time' => $request->time,
            ]);

            if ($request->hasFile('image')) {
                // Delete old images
                $oldImages = EventImage::where('event_id', $id)->get();
                foreach ($oldImages as $oldImage) {
                    if (file_exists(public_path($oldImage->name))) {
                        unlink(public_path($oldImage->name));
                    }
                }
                EventImage::where('event_id', $id)->delete();
                
                $uploadedFiles = $request->file('image');
                foreach ($uploadedFiles as $file) {
                    $fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
                    $file->move('uploads/event/', $fileName);
                    $profileUrls = 'uploads/event/' . $fileName;
                    
                    EventImage::create([
                        'event_id' => $event->id,
                        'name' => $profileUrls
                    ]);
                }
            }

            return response()->json(['success' => true, 'message' => 'Event Updated Successfully']);
        } catch (\Exception $e) {
            return $this->sendError($e->getMessage());
        }
    }

    public function destroy($id)
    {
        $event = Event::find($id);
        $event->delete();
        $images = EventImage::where('event_id',$id)->get();
        foreach($images as $image)
        {
            \File::delete($image->name);
            $image->delete();
        }
        return response()->json(['success'=>true,'message'=> 'Event Delete Successfully'],200);
    }
}
