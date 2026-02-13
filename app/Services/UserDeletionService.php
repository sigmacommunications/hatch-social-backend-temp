<?php
namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class UserDeletionService
{
    public function deleteUserCompletely(User $user): void
    {
        $profiles = $user->profiles()->get();
        $profileIds = $profiles->pluck('id');

        if ($profileIds->isEmpty()) {
            $this->deleteUserOnly($user);
            return;
        }

        $this->deleteProfileFiles($profiles);
        $this->deleteProfileData($profileIds, $user->id);
        $this->deleteUserOnly($user);
    }

    private function deleteUserOnly(User $user): void
    {
        DB::table('personal_access_tokens')
            ->where('tokenable_id', $user->id)
            ->delete();

        $user->delete();
    }

    /*
    |--------------------------------------------------------------------------
    | FILE DELETION
    |--------------------------------------------------------------------------
    */

    private function deleteProfileFiles($profiles): void
    {
        foreach ($profiles as $profile) {
            $this->deletePublicFile($profile->photo);
        }
    }

    private function deletePublicFile(?string $path): void
    {
        if ($path && file_exists(public_path($path))) {
            @unlink(public_path($path));
        }
    }

    private function deleteStorageFile(?string $path): void
    {
        if (!$path) return;

        $path = str_replace('/storage/', '', $path);

        if (Storage::disk('public')->exists($path)) {
            Storage::disk('public')->delete($path);
        }
    }

    private function deleteBunnyVideo(?string $videoId): void
    {
        if (!$videoId) return;

        try {
            Http::withHeaders([
                'AccessKey' => config('services.bunny.api_key')
            ])->delete(
                "https://video.bunnycdn.com/library/"
                . config('services.bunny.library_id')
                . "/videos/{$videoId}"
            );
        } catch (\Throwable $e) {
            Log::error('Bunny Delete Failed: '.$e->getMessage());
        }
    }

    /*
    |--------------------------------------------------------------------------
    | DATABASE CLEANUP
    |--------------------------------------------------------------------------
    */

    private function deleteProfileData($profileIds, int $userId): void
    {
        // Example clean deletion (rest aap relations ke through handle karein)
        
        \App\Models\Wallet::whereIn('profile_id', $profileIds)->delete();
        \App\Models\Post::whereIn('profile_id', $profileIds)->delete();
        \App\Models\Event::whereIn('profile_id', $profileIds)->delete();
        \App\Models\Product::whereIn('profile_id', $profileIds)->delete();
        \App\Models\Chat::whereIn('sender_id', $profileIds)
            ->orWhereIn('receiver_id', $profileIds)
            ->delete();

        \App\Models\Profile::whereIn('id', $profileIds)->delete();

        \App\Models\Subscription::where('user_id', $userId)->delete();
        \App\Models\Transaction::where('user_id', $userId)->delete();
    }
}