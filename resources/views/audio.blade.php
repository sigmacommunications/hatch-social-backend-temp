<!DOCTYPE html>
<html>
<head>
    <title>Agora Audio Calling</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
    <div class="container">
        <h3 class="mb-4">Agora Audio Calling</h3>

        <div class="mb-3">
            <input type="text" id="channelName" class="form-control" placeholder="Enter Channel/User Name">
        </div>

        <div class="mb-3">
            <button id="startCall" class="btn btn-success">📞 Start Call</button>
            <button id="joinCall" class="btn btn-primary">🔔 Join Call</button>
            <button id="leaveCall" class="btn btn-danger" disabled>🚫 Leave</button>
        </div>

        <div id="status" class="alert alert-info d-none"></div>
    </div>

    <script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.20.0.js"></script>
    <script>
        let client, localAudioTrack;
        let appID = '94a3f6e7183645efb14fa7318f669b95';
        let uid = null;

        const tokenUrl = "{{ url('agora/token') }}";
        const callAlertUrl = "{{ route('agora.call.alert') }}";
        const checkCallUrl = "{{ route('agora.check.call') }}";

        const callerId = {{ auth()->id() }};
        let pollingInterval = null;

        document.getElementById('startCall').onclick = async () => {
            const channelName = document.getElementById('channelName').value.trim();
            if (!channelName) return alert("Enter channel name");

            await fetch(callAlertUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({
                    channelName: channelName,
                    caller_id: callerId,
                    receiver_id: channelName
                })
            });

            alert('Call request sent. Waiting for receiver...');
            pollForAnswer(channelName);
        };

        async function pollForAnswer(channelName) {
            pollingInterval = setInterval(async () => {
                const res = await fetch(checkCallUrl, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                    },
                    body: JSON.stringify({ channelName })
                });

                const data = await res.json();
                if (data.status === 'accepted') {
                    clearInterval(pollingInterval);
                    joinAgoraCall(channelName);
                }
            }, 3000);
        }

        document.getElementById('joinCall').onclick = async () => {
            const channelName = document.getElementById('channelName').value.trim();
            if (!channelName) return alert("Enter channel name");

            // Accept the call
            await fetch(checkCallUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ channelName, accept: true })
            });

            await joinAgoraCall(channelName);
        };

        async function joinAgoraCall(channelName) {
            const tokenRes = await fetch(tokenUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ channelName })
            });

            const { token, uid: userId, appID: agoraAppId } = await tokenRes.json();
            uid = userId;
            appID = agoraAppId;

            client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });

            await client.join(appID, channelName, token, uid);
            localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
            await client.publish([localAudioTrack]);

            client.on("user-published", async (user, mediaType) => {
                await client.subscribe(user, mediaType);
                if (mediaType === "audio") {
                    user.audioTrack.play();
                    showStatus("Connected to call!");
                }
            });

            document.getElementById('leaveCall').disabled = false;
            showStatus("You are live in the call...");
        }

        document.getElementById('leaveCall').onclick = async () => {
            if (localAudioTrack) localAudioTrack.close();
            if (client) await client.leave();
            document.getElementById('leaveCall').disabled = true;
            showStatus("Call ended.");
        };

        function showStatus(message) {
            const statusDiv = document.getElementById('status');
            statusDiv.classList.remove('d-none');
            statusDiv.innerText = message;
        }
    </script>
</body>
</html>
