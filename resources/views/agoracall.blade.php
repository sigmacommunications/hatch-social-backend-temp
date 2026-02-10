<!DOCTYPE html>
<html>
<head>
    <title>Agora Audio Call</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="p-5">
<div class="container">
    <h3>Agora Audio Call</h3>

    <div class="mb-3">
        <input type="text" id="channel" class="form-control" placeholder="Enter Channel Name (e.g., user123)">
    </div>

    <button id="startCall" class="btn btn-success">📞 Call</button>
    <button id="joinCall" class="btn btn-primary">🔔 Join Call</button>
    <button id="leaveCall" class="btn btn-danger" disabled>🚫 Leave</button>
</div>

<script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.20.0.js"></script>
<script>
let client, localAudioTrack;
let appID = '94a3f6e7183645efb14fa7318f669b95';
let uid = null;

document.getElementById('startCall').onclick = async () => {
    const channelName = document.getElementById('channel').value.trim();
    if (!channelName) return alert("Channel name zaroori hai");

    const tokenRes = await fetch('/agora/token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ channelName })
    });

    const { token, uid: userId, appID: agoraAppId } = await tokenRes.json();
    uid = userId;
    appID = agoraAppId;

    client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });

    // Add listener here
    registerEventListeners();

    await client.join(appID, channelName, token, uid);
    localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
    await client.publish([localAudioTrack]);

    alert("Call started. Waiting for other user...");
    document.getElementById('leaveCall').disabled = false;
};

document.getElementById('joinCall').onclick = async () => {
    const channelName = document.getElementById('channel').value.trim();
    if (!channelName) return alert("Channel name zaroori hai");

    const tokenRes = await fetch('/agora/token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ channelName })
    });

    const { token, uid: userId, appID: agoraAppId } = await tokenRes.json();
    uid = userId;
    appID = agoraAppId;

    client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });

    // Add listener here
    registerEventListeners();

    await client.join(appID, channelName, token, uid);
    localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
    await client.publish([localAudioTrack]);

    alert("You joined the call!");
    document.getElementById('leaveCall').disabled = false;
};

document.getElementById('leaveCall').onclick = async () => {
    if (localAudioTrack) {
        localAudioTrack.stop();
        localAudioTrack.close();
    }

    if (client) {
        await client.leave();
    }

    alert("Call ended.");
    document.getElementById('leaveCall').disabled = true;
};

// ✅ Register leave event listener so other user leaves too
function registerEventListeners() {
    client.on("user-left", async (user) => {
        console.log("Remote user left:", user.uid);

        // Leave local client
        if (localAudioTrack) {
            localAudioTrack.stop();
            localAudioTrack.close();
        }

        try {
            await client.leave();
            alert("Dusre user ne call chhodi. Call end kar di gayi hai.");
            document.getElementById("leaveCall").disabled = true;
        } catch (e) {
            console.error("Leave error:", e);
        }
    });
}
</script>
</body>
</html>
