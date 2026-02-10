<!DOCTYPE html>
<html>
<head>
  <title>Agora Call</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <style>
    #local-container { display: none; }
    .remote-video { width: 100%; max-width: 400px; height: 240px; background: #000; margin: 10px auto; }
  </style>
</head>
<body class="p-3">
  <div class="container">
    <h4 class="text-center mb-4">Video Call</h4>
    <audio id="ringtone" src="/call.mp3" preload="auto"></audio>

    <div class="mb-3">
      <input type="text" id="channel" class="form-control mb-2" value="abc" placeholder="Channel">
      <input type="text" id="from_user_id" class="form-control mb-2" value="{{auth()->user()->id}}" readonly>
      <input type="number" id="to_user_id" class="form-control" placeholder="To User ID">
    </div>

    <div class="mb-3 d-grid gap-2">
      <button id="startCall" class="btn btn-success">Start Call</button>
      <button id="joinCall" class="btn btn-primary">Join Call</button>
      <button id="leaveCall" class="btn btn-danger" disabled>Leave</button>
    </div>

    <div id="local-container"></div>
    <div id="remote-container" class="d-flex flex-wrap justify-content-center"></div>
  </div>

  <script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.20.0.js"></script>
  <script>
let client, localAudioTrack, localVideoTrack, uid, appID = '94a3f6e7183645efb14fa7318f669b95';
const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
const fromUserId = document.getElementById('from_user_id').value;
const ringtone = document.getElementById('ringtone');

document.addEventListener('click', () => ringtone.play().then(() => ringtone.pause()), { once: true });

const checkDevices = () =>
  navigator.mediaDevices.enumerateDevices().then(devices => ({
    audio: devices.some(d => d.kind === 'audioinput'),
    video: devices.some(d => d.kind === 'videoinput')
  }));

const fetchToken = async channel => {
  const res = await fetch('/agora/token', {
    method: 'POST', headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken },
    body: JSON.stringify({ channelName: channel })
  });
  if (!res.ok) throw new Error('Token request failed');
  return res.json();
};

const joinChannel = async (channel, tokenData, devices) => {
  uid = tokenData.uid;
  client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });

  client.on("user-left", async user => {
    document.getElementById("remote-video-" + user.uid)?.remove();
    localAudioTrack?.stop(); localVideoTrack?.stop();
    localAudioTrack?.close(); localVideoTrack?.close();
    localAudioTrack = localVideoTrack = null;
    await client.leave(); client.removeAllListeners(); client = null;
    document.getElementById("local-container").innerHTML = "";
    document.getElementById("remote-container").innerHTML = "";
    document.getElementById("leaveCall").disabled = true;
    alert("The call has ended.");
  });

  client.on("user-published", async (user, mediaType) => {
    await client.subscribe(user, mediaType);
    if (mediaType === 'video') {
      const remoteDiv = document.createElement("div");
      remoteDiv.id = "remote-video-" + user.uid;
      remoteDiv.className = "remote-video";
      document.getElementById("remote-container").appendChild(remoteDiv);
      user.videoTrack.play(remoteDiv);
    } else if (mediaType === 'audio') {
      user.audioTrack.play();
    }
  });

  await client.join(appID, channel, tokenData.token, uid);

  const tracks = await Promise.all([
    devices.audio ? AgoraRTC.createMicrophoneAudioTrack().catch(() => null) : null,
    devices.video ? AgoraRTC.createCameraVideoTrack().catch(() => null) : null
  ]);
  localAudioTrack = tracks[0]; localVideoTrack = tracks[1];

  const publishTracks = [localAudioTrack, localVideoTrack].filter(Boolean);
  if (publishTracks.length) await client.publish(publishTracks);

  document.getElementById("leaveCall").disabled = false;
};

document.getElementById('startCall').onclick = async () => {
  const channel = document.getElementById('channel').value.trim();
  const toUserId = document.getElementById('to_user_id').value;
  if (!channel) return alert("Channel required");

  await fetch('/call/send', {
    method: 'POST', headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken },
    body: JSON.stringify({ from_user_id: fromUserId, to_user_id: toUserId, channel_name: channel })
  });

  const devices = await checkDevices();
  const tokenData = await fetchToken(channel);
  await joinChannel(channel, tokenData, devices);
  alert("Call started.");
};

document.getElementById('joinCall').onclick = async () => {
  const channel = document.getElementById('channel').value.trim();
  if (!channel) return alert("Channel required");
  const devices = await checkDevices();
  const tokenData = await fetchToken(channel);
  await joinChannel(channel, tokenData, devices);
  alert("Joined call.");
};

document.getElementById("leaveCall").onclick = async () => {
  localAudioTrack?.close(); localVideoTrack?.close();
  localAudioTrack = localVideoTrack = null;
  if (client) await client.leave(); client?.removeAllListeners(); client = null;
  document.getElementById("local-container").innerHTML = "";
  document.getElementById("remote-container").innerHTML = "";
  document.getElementById("leaveCall").disabled = true;

  await fetch('/call/end', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken },
    body: JSON.stringify({ accepted: 3, status: 'complete' })
  });

  alert("Call ended.");
};

setInterval(async () => {
  try {
    const res = await fetch(`/call/check/`);
    const data = await res.json();

    if (data.call && (data.call.status === 'complete' || data.call.accepted == 3)) {
      await client?.leave(); client = null;
      localAudioTrack?.close(); localVideoTrack?.close();
      localAudioTrack = localVideoTrack = null;
      document.getElementById("local-container").innerHTML = "";
      document.getElementById("remote-container").innerHTML = "";
      document.getElementById("leaveCall").disabled = true;
      alert("📴 Call ended.");
      return;
    }

    if (data.call_canceled) {
      await fetch('/call/accept', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken },
        body: JSON.stringify({ call_id: data.call.id, accepted: 3, status: 'complete' })
      });
      await client?.leave(); client = null;
      document.getElementById("local-container").innerHTML = "";
      document.getElementById("remote-container").innerHTML = "";
      document.getElementById("leaveCall").disabled = true;
      alert("Call was canceled.");
      return;
    }

    if (data.call && data.call.status === 'ringing' ) {
      ringtone.loop = true;
      ringtone.play();
      const accept = confirm(`📞 Call from ${data.call.caller_id}. Accept?`);
      ringtone.pause(); ringtone.currentTime = 0;

      await fetch('/call/accept', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken },
        body: JSON.stringify({
          call_id: data.call.id,
          accepted: accept ? 1 : 2,
          status: accept ? 'accept' : 'cancel'
        })
      });

      document.getElementById('channel').value = data.call.channel_name;
      if (accept) document.getElementById('joinCall').click();
    }
  } catch (e) {
    console.error("Call check error:", e);
  }
}, 5000);
  </script>
</body>
</html>
