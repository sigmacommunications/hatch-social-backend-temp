<!DOCTYPE html>
<html>
<head>
    <title>Video Call</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        #local, #remote {
            width: 100%;
            max-width: 500px;
            height: 300px;
            background: #000;
            margin: 10px auto;
        }
        #buttons {
            text-align: center;
            margin-top: 10px;
        }
        button {
            margin: 5px;
            padding: 10px 15px;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Video Call Interface</h2>

<div id="local"></div>
<div id="remote"></div>

<div id="buttons">
    <button onclick="initiateCall(2)">Call User 2</button>
    <button onclick="acceptCall()" id="accept" style="display:none;">Accept</button>
    <button onclick="rejectCall()" id="reject" style="display:none;">Reject</button>
</div>

<script type="module">
    import AgoraRTC from 'https://cdn.skypack.dev/agora-rtc-sdk-ng';

    const APP_ID = "{{ env('AGORA_APP_ID') }}";
    let CHANNEL = "", callId = "", TOKEN = "", client, localTrack;

    async function initiateCall(receiver_id) {
        let res = await fetch('/call/initiate', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({ receiver_id })
        });
        let data = await res.json();
        CHANNEL = data.channel;
        callId = data.call_id;
        joinAgora();
    }

    async function joinAgora() {
        client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
        await client.join(APP_ID, CHANNEL, TOKEN, null);
        localTrack = await AgoraRTC.createCameraVideoTrack();
        localTrack.play("local");
        await client.publish([localTrack]);
    }

    setInterval(async () => {
        let res = await fetch('/call/check');
        let data = await res.json();
        if (data.call && data.call.channel_name !== CHANNEL) {
            callId = data.call.id;
            CHANNEL = data.call.channel_name;
            document.getElementById('accept').style.display = 'inline-block';
            document.getElementById('reject').style.display = 'inline-block';
        }
    }, 5000);

    async function acceptCall() {
        await fetch('/call/update/' + callId, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({ status: 'accepted' })
        });
        client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
        await client.join(APP_ID, CHANNEL, TOKEN, null);
        client.on("user-published", async (user, mediaType) => {
            await client.subscribe(user, mediaType);
            if (mediaType === "video") {
                const remoteTrack = user.videoTrack;
                remoteTrack.play("remote");
            }
        });
    }

    async function rejectCall() {
        await fetch('/call/update/' + callId, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({ status: 'rejected' })
        });
        alert("Call Rejected");
        document.getElementById('accept').style.display = 'none';
        document.getElementById('reject').style.display = 'none';
    }
</script>

</body>
</html>
