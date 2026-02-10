<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class NewMessageNotification extends Mailable
{
    use Queueable, SerializesModels;

    public $message;
    public $sender;
    public $receiverId;

    /**
     * Create a new message instance.
     */
    public function __construct($message, $receiverId)
    {
        $this->message = $message;
        $this->sender = $message->user;
        $this->receiverId = $receiverId;
    }

    /**
     * Build the message.
     */
    public function build()
    {
        return $this->subject('New Message Received - ' . config('app.name'))
                    ->view('emails.new_message')
                    ->with([
                        'messageText' => $this->message->text,
                        'senderName' => $this->sender->name,
                        'receiverId' => $this->receiverId,
                    ]);
    }
}