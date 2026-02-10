<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class MonetizationRequestMail extends Mailable
{
    use Queueable, SerializesModels;

    public $community;

    /**
     * Create a new message instance.
     */
    public function __construct($community)
    {
        $this->community = $community;
    }

    /**
     * Build the message.
     */
    public function build()
    {
        return $this->subject('Request for Monetization')
            ->view('emails.monetization_request');
    }
}
