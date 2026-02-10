<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PaymentCommunityJoinMail extends Mailable
{
    use Queueable, SerializesModels;

//    public $community;
	public $comdata;

    /**
     * Create a new message instance.
     */
    public function __construct($comdata) // Parameter name change
    {
        $this->comdata = $comdata;
    }
    /**
     * Build the message.
     */
    public function build()
    {
        return $this->subject('Community Joining Payment')
            ->view('emails.community_join_payment');
    }
}
