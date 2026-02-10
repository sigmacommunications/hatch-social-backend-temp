<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Community Joining Payment</title>
</head>
<body>
    <a href="https://hatch-social.cstmpanel.com/community_join/{{$comdata['id']}}?price={{$comdata['price']}}&profile_id={{$comdata['profile_id']}}&role=member">
        Click To Payment
    </a>
    
    <h2>Community Joining Payment Required</h2>
    <p><strong>Joining Cost:</strong> ${{ $comdata['price'] }}</p>
    <p>Please click the link above to complete your payment and join the community.</p>
</body>
</html>