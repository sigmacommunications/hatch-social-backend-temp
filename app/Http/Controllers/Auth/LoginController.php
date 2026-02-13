<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Mail;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login()
    {
        return view('auth.login');
    }

    public function sendOtpToVerifyEmail(Request $request)
	{
		$validator = Validator::make($request->all(), [
			'email' => 'required|email|exists:users,email',
		]);
		if ($validator->fails()) 
		{
        	return redirect()->back()
            ->withErrors($validator) // Add validation errors to session
            ->withInput();
    	}

		$user = User::where('email', $request->email)->first();

		// Generate and save OTP
		$otp = rand(100000, 999999); // 6-digit OTP
		$user->email_code = $otp;
		$user->save();

		// Send OTP via email
		Mail::raw("Your verification code is: $otp", function ($message) use ($user) {
			$message->to($user->email)
				->subject('Email Verification OTP');
		});

		// Set session flag
		session(['otp_sent' => true, 'email' => $user->email]);

		return redirect()->back()->with('success', 'OTP sent to your email.');
	}
	
	public function verifyOtpAndDeleteUser(Request $request)
    {
        $request->validate([
            'email' => ['required', 'email', 'exists:users,email'],
            'otp'   => ['required', 'digits:6'],
        ]);

        try {
            \DB::beginTransaction();

            $user = User::where('email', $request->email)->firstOrFail();

            // TODO: Yahan OTP verification logic add karein

            app(\App\Services\UserDeletionService::class)
                ->deleteUserCompletely($user);

            \DB::commit();

            session()->forget(['otp_sent', 'email']);

            return back()->with('success', 'Account deleted successfully.');

        } catch (\Throwable $e) {

            \DB::rollBack();
            Log::error('User Deletion Failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return back()->with('error', 'Something went wrong while deleting account.');
        }
    }

    // public function admin(Request $request)
    // {
    //     try {
    //         $validator = Validator::make($request->all(), [
    //             'email' => 'required|email|exists:users',
    //             'password' => 'required'
    //         ]);
    //         if ($validator->fails()) {
    //             return redirect()->back()->with(['error' => $validator->errors()->first()]);
    //         }
    //         if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
    //             $user = Auth::user();
    //             return redirect()->route('dashboard');
    //             if ($user->role == 'admin') {


    //                 return redirect()->route('dashboard');
    //             } else {
    //                 //\Auth::logout();
    //                 request()->session()->flash('error', 'You do not have any permission to access this pages');
    //                 return redirect()->to('/');
    //             }
    //         } else {
    //             return back()->with(['error' => 'Invalid Credentials']);
    //         }
    //     } catch (\Exception $e) {
    //         return redirect()->back()->with(['error' => $e->getMessage()]);
    //     }
    // }

    public function admin(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'email' => 'required|email|exists:users',
                'password' => 'required'
            ]);

            if ($validator->fails()) {
                return redirect()->back()->with(['error' => $validator->errors()->first()]);
            }

            if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
                $user = Auth::user();
                // ✅ Check the user's role and redirect accordingly
                if ($user->role === 'admin') {
                    return redirect()->route('dashboard')
                        ->with('success', 'Welcome back, Admin!');
                } else {
                    // ✅ Redirect normal users to their profile page
                    return redirect()->to('users/profile/' . $user->id)
                        ->with('success', 'Welcome back, ' . $user->name . '!');
                    // dd($user->role);
                }
            } else {
                return back()->with(['error' => 'Invalid credentials']);
            }
        } catch (\Exception $e) {
            return redirect()->back()->with(['error' => $e->getMessage()]);
        }
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect()->route('login');
    }
}
