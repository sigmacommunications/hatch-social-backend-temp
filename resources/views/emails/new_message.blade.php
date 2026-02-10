<!DOCTYPE html>
<html>
<head>
    <title>New Message Notification</title>
</head>
<body>
    <h2>New Message Received</h2>
    
    <p>Hello,</p>
    
    <p>You have received a new message from <strong>Hatch Social</strong>:</p>
    
    <div style="background: #f5f5f5; padding: 15px; border-radius: 5px; margin: 10px 0;">
        {{ $messageText }}
    </div>
    
    <p>
        <a href="{{ url('/profiles/chat/' . $receiverId) }}" style="background: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
            View Message
        </a>
    </p>
    
    <p>Thank you,<br>Hatch Social</p>
</body>
</html>