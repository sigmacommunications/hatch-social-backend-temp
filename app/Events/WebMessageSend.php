<?php

namespace App\Events;

use App\Models\User;
use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;

class WebMessageSend implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $message;
    public $receiverId;

    /**
     * Create a new event instance.
     */
    public function __construct($message, $receiverId)
    {
        $this->message = $message;
        $this->receiverId = $receiverId;
    }

    /**
     * Get the channels the event should broadcast on.
     */
    public function broadcastOn()
    {
        // Each user gets their own private channel
        return new PrivateChannel('chat.' . $this->receiverId);
    }

    /**
     * Customize event name for frontend listener.
     */
    public function broadcastAs()
    {
        return 'MessageSent';
    }

    /**
     * Optional: sanitize data before broadcasting
     */
    public function broadcastWith()
    {
        return [
            'message' => $this->message
        ];
    }
}
