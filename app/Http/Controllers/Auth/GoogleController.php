<?php
namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Http\Request;
use App\Models\User;
use Google_Client;
use App\Models\Wallet;

class GoogleController extends Controller
{
    public function login(Request $request)
    {

        \Log::info($request->all());

        $idToken = $request->idToken;

        $client = new \Google\Client(['client_id' => env('GOOGLE_CLIENT_ID')]); // Google Client ID
        $payload = $client->verifyIdToken($idToken);

        if ($payload) {
            // Extract user details
            $googleId = $payload['sub'];
            $email = $payload['email'];
			//$role = $payload['role'];
            $name = $payload['name'];
            $current_plan = 'Premium';

            // Find or create user
            $user = User::updateOrCreate(
                ['google_id' => $googleId],
                ['email' => $email, 'first_name' => $name,'current_plan' => 'Premium']
            );

			
			//$rider = User::find($user->id);
			$users = User::withCount('profiles as total_profile')->with('profiles')->find($user->id);

            // Generate token
            $token = $users->createToken('authToken')->plainTextToken;

            return response()->json(['success'=>true,'message'=>'User login successfully','token' => $token,'user_info'=>$users], 200);
        } else {
            return response()->json(['message' => 'Invalid Google token'], 404);
        }
    }

}
