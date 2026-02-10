@extends('admin.layouts.master')
@section('title', 'Nests')

@section('styles')
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">
<style>
    .page-heading { display:flex; align-items:center; justify-content:space-between; gap:1rem; }
    .page-heading h2 { margin:0; font-weight:700; }
    .table-card { background:#fff; border:1px solid #eef1f7; border-radius:14px; box-shadow:0 12px 32px rgba(0,0,0,0.04); padding:18px; }
    .datatable-wrap { overflow-x:auto; }
    .badge-pill { padding:6px 10px; border-radius:999px; font-size:12px; }
    .search-container { display:flex; gap:10px; flex-wrap:wrap; align-items:center; width:100%; }
    .search-box { flex:1; min-width:260px; }
    .btn-upgrade { white-space:nowrap; }
    /* Compact chat modal */
    #chatModal { position:fixed; bottom:20px; right:20px; width:360px; height:520px; background:#fff; border-radius:12px; overflow:hidden; box-shadow:0 4px 20px rgba(0,0,0,0.2); z-index:9999; display:none; flex-direction:column; }
    .chat-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.3); z-index:9998; }
    .user-bar { height:64px; background:#0f172a; color:#fff; display:flex; align-items:center; gap:10px; padding:0 14px; }
    .user-bar img { width:42px; height:42px; border-radius:50%; object-fit:cover; border:2px solid #fff; }
    .conversation { flex:1; overflow-y:auto; padding:12px; background:#f7f7f7; }
    .message { padding:10px 12px; margin:6px 0; border-radius:10px; max-width:80%; }
    .message.sent { background:#e0f2fe; margin-left:auto; }
    .message.received { background:#fff; }
    .conversation-compose { display:flex; gap:6px; padding:10px; border-top:1px solid #e5e7eb; }
    .conversation-compose input { flex:1; border:1px solid #e5e7eb; border-radius:20px; padding:10px 14px; }
    .conversation-compose button { border:none; border-radius:50%; width:42px; height:42px; background:#2563eb; color:#fff; }
    .modal-close-btn { background:none; border:none; font-size:1.4rem; cursor:pointer; }
</style>
@endsection

@section('content')
<div class="container-fluid py-4">
    <div class="page-heading mb-3">
        <div>
            <h2>Nests</h2>
            <p class="text-muted mb-0">Revenue and upgrade controls for this profile.</p>
        </div>
        <a href="{{ route('users.profile.index', $profile->user_id ?? $profile->id) }}" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left"></i> Back to Profiles
        </a>
    </div>

    <div class="table-card">
        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
            <div>
                <h5 class="mb-0">Nest Performance</h5>
                <small class="text-muted">Client vs HS cuts, upgrade membership, and chat.</small>
            </div>
            <div class="search-container">
                <div class="search-box">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass"></i></span>
                        <input type="search" placeholder="Search nests..." class="form-control border-start-0" id="nestSearch">
                    </div>
                </div>
                <div class="chat-button-container">
                    <button class="btn btn-primary d-flex align-items-center gap-2"
                            data-user-id="{{ $profile->id }}"
                            data-user-name="{{ $profile->profile_name }}"
                            data-user-type="User"
                            data-user-photo="{{ $profile->profile_photo ?? 'https://mehedihtml.com/chatbox/assets/img/user.png' }}">
                        <i class="fa-solid fa-comments"></i> Start Chat
                    </button>
                </div>
            </div>
        </div>

        <div class="table-responsive datatable-wrap">
            <table class="table align-middle" id="nestTable">
                <thead class="table-light">
                    <tr>
                        <th>S.N</th>
                        <th>Nest Name</th>
                        <th>Client Cut</th>
                        <th>HS - Cut</th>
                        <th>Client Revenue</th>
                        <th>HS - Revenue</th>
                        <th>Revenue</th>
                        <th>Refund Case</th>
                        <th>Dispute Case</th>
                        <th class="text-end">Action</th>
                    </tr>
                </thead>
                <tbody>
                    @if($users)
                        @foreach ($users as $user)
                            <tr data-user-id="{{ $user->id }}">
                                <td>{{ ++$i }}</td>
                                <td class="fw-semibold">{{ $user->title }}</td>
                                <td><span class="badge-pill bg-primary-subtle text-primary">{{ $user->client_cut }}%</span></td>
                                <td><span class="badge-pill bg-warning-subtle text-warning">{{ $user->hs_cut }}%</span></td>
                                <td>${{ number_format($user->client_revenue, 2) }}</td>
                                <td>${{ number_format($user->hs_revenue, 2) }}</td>
                                <td>${{ number_format($user->total_earn_join_amount, 2) }}</td>
                                <td>N/A</td>
                                <td>N/A</td>
                                <td class="text-end">
                                    @if ($user->app_service_charges === 0)
                                        <button class="btn btn-sm btn-warning upgrade-btn btn-upgrade" data-user-id="{{ $user->id }}">Upgrade</button>
                                    @else
                                        <span class="badge bg-success-subtle text-success">Upgraded</span>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    @endif
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="chat-overlay"></div>
<div id="chatModal">
    <div class="user-bar">
        <img id="chatUserPhoto" src="https://mehedihtml.com/chatbox/assets/img/user.png" alt="Avatar">
        <div>
            <div id="chatUserName" class="fw-semibold">Select a user</div>
            <small id="chatUserStatus" class="text-light opacity-75">Click start chat</small>
        </div>
        <button class="modal-close-btn ms-auto text-white close-chat">&times;</button>
    </div>
    <div class="conversation" id="message-container">
        <div id="message-list" class="conversation-container">
            <div class="text-center text-muted">No messages yet. Start the conversation!</div>
        </div>
    </div>
    <div class="conversation-compose">
        <input type="text" class="input-msg" id="messageInput" placeholder="Type a message..." autocomplete="off">
        <button class="send" id="sendMessageBtn"><i class="fa fa-paper-plane"></i></button>
    </div>
</div>

<div class="modal fade" id="upgradeModal" tabindex="-1" role="dialog" aria-labelledby="upgradeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="upgradeModalLabel">Upgrade Membership</h5>
                <button type="button" class="modal-close-btn" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="upgradeForm">
                <div class="modal-body">
                    <input type="hidden" id="upgradeUserId">
                    <div class="form-group">
                        <label for="upgradeAmount">Enter Upgrade Amount</label>
                        <input type="number" id="upgradeAmount" class="form-control" placeholder="Enter amount" required min="1">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-warning">Save Upgrade</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script src="https://js.pusher.com/8.2/pusher.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/laravel-echo/1.15.3/echo.iife.js"></script>
<script>
$(function () {
    const table = $('#nestTable').DataTable({
        responsive: true,
        autoWidth: false,
        pageLength: 10,
        lengthChange: false,
        columnDefs: [{ targets: -1, orderable: false, searchable: false }],
        language: { search: '', searchPlaceholder: 'Search nests...', paginate: { previous: '<', next: '>' } }
    });
    $('#nestSearch').on('keyup change', function () { table.search(this.value).draw(); });

    let authId = "{{ Auth::id() }}";
    let currentReceiver = null;
    let currentReceiverName = null;

    window.Echo = new Echo({
        broadcaster: 'pusher',
        key: 'e2bf086cd39dc73de723',
        cluster: 'ap1',
        forceTLS: true
    });

    const chatButtons = document.querySelectorAll('.chat-button-container button');
    const chatModal = document.getElementById('chatModal');
    const overlay = document.querySelector('.chat-overlay');
    const closeChat = document.querySelector('.close-chat');
    const chatUserName = document.getElementById('chatUserName');
    const chatUserPhoto = document.getElementById('chatUserPhoto');
    const chatUserStatus = document.getElementById('chatUserStatus');
    const messageInput = document.getElementById('messageInput');
    const sendMessageBtn = document.getElementById('sendMessageBtn');

    function scrollToBottom() {
        const container = document.getElementById('message-container');
        if (container) container.scrollTop = container.scrollHeight;
    }

    function addMessage(message, isSent = false, senderName = '', timestamp = null) {
        const messageClass = isSent ? 'sent' : 'received';
        const time = timestamp ? moment(timestamp).format('h:mm A') : moment().format('h:mm A');
        const senderDisplay = isSent ? 'You' : senderName;
        const list = $('#message-list');

        if (list.find('.no-messages').length) list.empty();
        list.append(`
            <div class="message ${messageClass}">
                <div class="sender-name">${senderDisplay}</div>
                <div class="message-text">${message}</div>
                <small class="text-muted d-block mt-1">${time}</small>
            </div>
        `);
        scrollToBottom();
    }

    function markMessagesAsRead(senderId) {
        $.post('/mark-messages-read', { sender_id: senderId, _token: '{{ csrf_token() }}' });
    }

    window.Echo.private(`chat.${authId}`).listen('.MessageSent', function(e) {
        const senderId = parseInt(e.message.sender_id);
        const receiverId = parseInt(e.message.receiver_id);
        const currentRec = parseInt(currentReceiver);
        const isRead = e.message.is_read || 0;

        if (currentRec && (currentRec === senderId || currentRec === receiverId)) {
            const isSent = senderId === parseInt(authId);
            const senderName = isSent ? 'You' : e.message.sender_name || currentReceiverName;
            addMessage(e.message.text, isSent, senderName, e.message.created_at);
            if (!isSent && isRead === 0) markMessagesAsRead(senderId);
        }
    });

    chatButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const userId = btn.dataset.userId;
            const userName = btn.dataset.userName;
            const userType = btn.dataset.userType;
            const userPhoto = btn.dataset.userPhoto;

            currentReceiver = userId;
            currentReceiverName = userName;
            chatUserName.textContent = userName;
            chatUserStatus.textContent = userType + ' • Online';
            chatUserPhoto.src = userPhoto;

            chatModal.style.display = 'flex';
            overlay.style.display = 'block';

            $('#message-list').html(`<div class="text-center text-muted no-messages">Loading messages...</div>`);
            $.get(`/get-messages/${userId}`, function(messages) {
                const list = $('#message-list');
                if (Array.isArray(messages) && messages.length) {
                    list.empty();
                    messages.forEach(msg => {
                        const isSent = parseInt(msg.sender_id) === parseInt(authId);
                        const senderName = isSent ? 'You' : (msg.sender_name || currentReceiverName);
                        addMessage(msg.text, isSent, senderName, msg.created_at);
                    });
                } else {
                    list.html(`<div class="text-center text-muted no-messages">No messages yet. Start the conversation!</div>`);
                }
                scrollToBottom();
                markMessagesAsRead(userId);
            }).fail(() => {
                $('#message-list').html(`<div class="text-center text-danger">Error loading messages.</div>`);
            });
        });
    });

    function hideChat() {
        chatModal.style.display = 'none';
        overlay.style.display = 'none';
        currentReceiver = null;
        currentReceiverName = null;
    }
    closeChat.addEventListener('click', hideChat);
    overlay.addEventListener('click', hideChat);

    function sendMessage() {
        const receiverId = currentReceiver;
        const message = messageInput.value.trim();
        if (!message || !receiverId) return;

        addMessage(message, true, 'You');
        messageInput.value = '';

        $.post('/send-messages', { receiver_id: receiverId, message: message, _token: '{{ csrf_token() }}' })
            .done(() => { scrollToBottom(); markMessagesAsRead(receiverId); })
            .fail(() => { $('#message-list .message:last').remove(); alert('Failed to send message.'); });
    }
    sendMessageBtn.addEventListener('click', sendMessage);
    messageInput.addEventListener('keypress', function(e) {
        if (e.which === 13 && !e.shiftKey) { e.preventDefault(); sendMessage(); }
    });

    const upgradeModal = $("#upgradeModal");
    document.querySelectorAll(".upgrade-btn").forEach(btn => {
        btn.addEventListener("click", function(e) {
            e.stopPropagation();
            $("#upgradeUserId").val(this.getAttribute("data-user-id"));
            $("#upgradeAmount").val("");
            upgradeModal.modal("show");
        });
    });
    $('[data-dismiss="modal"]').on('click', function() { upgradeModal.modal('hide'); });
    upgradeModal.on('click', function(e) { if (e.target === this) upgradeModal.modal('hide'); });

    $("#upgradeForm").on("submit", function(e) {
        e.preventDefault();
        const userId = $("#upgradeUserId").val();
        const amount = $("#upgradeAmount").val();
        if (!amount || amount <= 0) { alert("Please enter a valid amount."); return; }

        $.post(`/users/${userId}/upgrade`, { amount: amount, _token: '{{ csrf_token() }}' })
            .done(function(response) {
                alert(response.message || "Upgrade successful!");
                const row = document.querySelector(`tr[data-user-id="${userId}"]`);
                if (row) {
                    row.querySelector(".btn-upgrade")?.remove();
                    const cell = row.querySelector("td:last-child");
                    if (cell) cell.innerHTML = '<span class="badge bg-success-subtle text-success">Upgraded</span>';
                }
                upgradeModal.modal("hide");
            })
            .fail(function(xhr) {
                alert("Error: " + (xhr.responseJSON?.message || "Something went wrong!"));
            });
    });
});
</script>
@endsection
