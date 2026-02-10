<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Community Upgrade Notification</title>
</head>

<body style="font-family: Arial, sans-serif; background-color: #f6f6f6; padding: 30px;">

    <div style="background-color: #ffffff; padding: 20px; border-radius: 8px;">
        <h2 style="color: #333;">Hello {{ $profile->name ?? 'User' }},</h2>

        <p>
            Great news! Your community <strong>{{ $community->title }}</strong> has been successfully upgraded.
        </p>

        <p>
            <strong>Upgrade Amount:</strong> ${{ number_format($amount, 2) }}
        </p>

        {{-- ✅ Check if Stripe ID is missing --}}
        @if (empty($profile->user->stripe_id))
            <div
                style="margin-top: 20px; background-color: #fff3cd; padding: 15px; border-radius: 5px; border: 1px solid #ffeeba;">
                <p style="color: #856404;">
                    ⚠️ It looks like you haven’t added your card details yet. Please add your payment method to complete
                    your account setup.
                </p>
                <a href="{{ url('/billing/setup') }}"
                    style="display:inline-block; background-color:#007bff; color:#fff; padding:10px 20px; text-decoration:none; border-radius:5px;">
                    Add Card Details
                </a>
            </div>
        @endif

        <p style="margin-top: 25px;">
            Thank you for being part of our platform!
        </p>

        <hr>
        <p style="font-size: 12px; color: #777;">
            This is an automated message from HatchSocial. Please do not reply.
        </p>
    </div>

</body>

</html>
