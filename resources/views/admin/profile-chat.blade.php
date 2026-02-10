@extends('admin.layouts.master')
@section('title', 'Users')
@section('content')

<style>
.message-area {
    height: 100vh;
    background: #f8f9fa;
    padding: 20px 0;
}

.chat-area {
    background: white;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    height: 85vh;
    overflow: hidden;
}

.chatlist {
    width: 350px;
    border-right: 1px solid #e9ecef;
    height: 100%;
    overflow-y: auto;
    background: white;
}

.chatbox {
    flex: 1;
    display: flex;
    flex-direction: column;
    height: 100%;
}

.chat-user {
    padding: 15px;
    border-bottom: 1px solid #e9ecef;
    cursor: pointer;
    transition: background 0.3s;
}

.chat-user:hover {
    background: #f8f9fa;
}

.chat-user.active {
    background: #e3f2fd;
    border-left: 3px solid #2196f3;
}

.chat-user.unread {
    background: #fff3cd;
    border-left: 3px solid #ffc107;
}

.user-avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
}

.chat-header {
    padding: 20px;
    border-bottom: 1px solid #e9ecef;
    background: white;
}

.message-container {
    flex: 1;
    overflow-y: auto;
    padding: 20px;
    background: #f8f9fa;
}

.message {
    max-width: 70%;
    margin-bottom: 15px;
    padding: 12px 16px;
    border-radius: 18px;
    position: relative;
    clear: both;
}

/* MY MESSAGES (SENT) - Blue color on right side */
.message.sent {
    background: #007bff;
    color: white;
    float: right;
    border-bottom-right-radius: 5px;
    margin-left: auto;
}

/* OTHER PERSON MESSAGES (RECEIVED) - Light gray on left side */
.message.received {
    background: white;
    color: #333;
    border: 1px solid #e9ecef;
    float: left;
    border-bottom-left-radius: 5px;
    margin-right: auto;
}

/* Message sender name */
.sender-name {
    font-size: 12px;
    font-weight: bold;
    margin-bottom: 5px;
    opacity: 0.8;
}

.message.sent .sender-name {
    color: #e3f2fd;
    text-align: right;
}

.message.received .sender-name {
    color: #666;
    text-align: left;
}

.message-time {
    font-size: 11px;
    opacity: 0.7;
    margin-top: 5px;
    display: block;
}

.message.sent .message-time {
    text-align: right;
    color: #e3f2fd;
}

.message.received .message-time {
    text-align: left;
    color: #666;
}

.message-input-container {
    padding: 20px;
    border-top: 1px solid #e9ecef;
    background: white;
}

.message-input {
    border-radius: 25px;
    padding: 12px 20px;
    border: 1px solid #ddd;
}

.send-btn {
    border-radius: 50%;
    width: 45px;
    height: 45px;
    background: #007bff;
    border: none;
    color: white;
    margin-left: 10px;
}

.chat-placeholder {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    background: white;
}

.status-online {
    position: absolute;
    bottom: 5px;
    right: 5px;
    width: 12px;
    height: 12px;
    background: #28a745;
    border: 2px solid white;
    border-radius: 50%;
}

.new-message-badge ,.unread-count-badge {
    color: red;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
}
	
	


.unread-indicator {
    position: absolute;
    top: 50%;
    right: 15px;
    transform: translateY(-50%);
    width: 8px;
    height: 8px;
    background: #dc3545;
    border-radius: 50%;
    animation: pulse 1.5s infinite;
}

@keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.5; }
    100% { opacity: 1; }
}

/* Clear floats */
.message-container::after {
    content: "";
    display: table;
    clear: both;
}

/* Scrollbar styling */
.message-container::-webkit-scrollbar {
    width: 6px;
}

.message-container::-webkit-scrollbar-track {
    background: #f1f1f1;
}

.message-container::-webkit-scrollbar-thumb {
    background: #c1c1c1;
    border-radius: 3px;
}

.message-container::-webkit-scrollbar-thumb:hover {
    background: #a8a8a8;
}

@media (max-width: 1023px) {
	.chatlist {
        width: 80% !important;
        height: 85% !important;
		border-right: none;
        border-bottom: 1px solid #e9ecef;
        position: absolute;
		z-index: 1;
		transition: 0.5s;
    }
    
    .chatbox {
        height: 100%;
    }
	
	.chatlist.show {
		position: relative;
		display: none;
	}
	
	#backBtn {
		background: transparent;
		border: 0;
		color: #fff;
		font-size: 20px;
	}

	#chat-user-name {
		font-size: 16px;
	}

	#chat-user-type {
		font-size: 10px;
	}
	
	.sender-name {
    	font-size: 10px;
	}
	
	.message-text {
		font-size: 14px;
	}
	
	.message-time {
    	font-size: 8px;
	}
	
	.message-input-container input {
    	font-size: 14px;
	}
}
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<section class="message-area">
    <div class="container h-100">
        <div class="row h-100">
            <div class="col-12 h-100">
                <div class="chat-area d-flex">
                    <!-- Users List -->
                    <div class="chatlist">
                        <div class="p-3 border-bottom bg-light">
                            <h5 class="mb-0 text-primary"><i class="fas fa-comments me-2"></i>Chat</h5>
                        </div>
                        <div class="users-list">
                            @if($user)
                            <div class="chat-user position-relative" 
                                 data-id="1"
                                 data-name="{{ $user->first_name }}"
                                 data-type="{{ $user->role }}"
                                 data-photo="{{ $user->photo ? '/' . $user->photo : 'https://mehedihtml.com/chatbox/assets/img/user.png' }}">
                                <div class="d-flex align-items-center">
                                    <div class="position-relative">
                                        <img src="{{ $user->photo ? '/' . $user->photo : 'https://mehedihtml.com/chatbox/assets/img/user.png' }}" 
                                             class="user-avatar" alt="{{ $user->first_name }}">
                                        <span class="status-online"></span>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-1 fw-bold">{{ $user->first_name }}</h6>
                                        <p class="mb-0 text-muted small">{{ $user->role }}</p>
                                    </div>
                                    <!-- New Message Indicators -->
									@if($user->unread_count > 0)
                                    <span class="new-message-badge"> {{$user->unread_count}}</span>
									@else
									<span class="unread-count-badge" id="unread-{{ $user->id }}"></span>
									@endif
                                </div>
                            </div>
                            @endif
                        </div>
                    </div>

                    <!-- Chat Box - Initially Hidden -->
                    <div class="chatbox" id="chatbox" style="display: none;">
                        <div class="chat-header bg-primary text-white">
                            <div class="d-flex align-items-center">
								<button id="backBtn">
									<i class="fa-solid fa-angle-left"></i>
								</button>
                                <div class="position-relative me-3">
                                    <img id="chat-user-photo" 
                                         src="https://mehedihtml.com/chatbox/assets/img/user.png" 
                                         class="user-avatar" alt="User">
                                    <span class="status-online"></span>
                                </div>
                                <div>
                                    <h5 id="chat-user-name" class="mb-1">Select a user</h5>
                                    <p id="chat-user-type" class="mb-0 opacity-75">Click on user to start chatting</p>
                                </div>
                            </div>
                        </div>

                        <div class="message-container" id="message-container">
                            <div id="message-list"></div>
                        </div>

                        <div class="message-input-container">
                            <div class="d-flex align-items-center">
                                <input type="text" 
                                       class="form-control message-input" 
                                       id="messageInput" 
                                       placeholder="Type a message...">
                                <button class="send-btn" id="sendMessageBtn">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Placeholder - Initially Visible -->
                    <div class="chat-placeholder flex-grow-1" id="chat-placeholder">
                        <div class="text-center text-muted">
                            <i class="fas fa-comments fa-4x mb-3 text-primary"></i>
                            <h4 class="text-dark">Start a Conversation</h4>
                            <p>Click on the user to begin chatting</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://js.pusher.com/8.2/pusher.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/laravel-echo/1.15.3/echo.iife.js"></script>

<script>
$(document).ready(function() {
    let authId = "{{ request()->segment(3) }}";
    let currentReceiver = null;
    let currentReceiverName = null;

    // Initialize Echo
    window.Echo = new Echo({
        broadcaster: 'pusher',
        key: 'e2bf086cd39dc73de723',
        cluster: 'ap1',
        forceTLS: true
    });

    // Auto scroll to bottom
    function scrollToBottom() {
        const container = document.getElementById('message-container');
        if (container) {
            container.scrollTop = container.scrollHeight;
        }
    }

    // Add message to chat
    function addMessage(message, isSent = false, senderName = '', timestamp = null) {
        const messageClass = isSent ? 'sent' : 'received';
        const time = timestamp ? new Date(timestamp).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'}) 
                              : new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        
        const senderDisplay = isSent ? 'You' : senderName;
        
        $('#message-list').append(`
            <div class="message ${messageClass}">
                <div class="sender-name">${senderDisplay}</div>
                <div class="message-text">${message}</div>
                <small class="message-time">${time}</small>
            </div>
        `);
        
        scrollToBottom();
    }

    // Show new message notification
    function showNewMessageNotification(senderId) {
        const chatUser = $(`.chat-user[data-id="${senderId}"]`);
        if (chatUser.length) {
            // Add unread class for background highlight
            chatUser.addClass('unread');
            
            // Show badge with exclamation mark
            chatUser.find('.new-message-badge').fadeIn();
            
            // Show pulsing dot indicator
            chatUser.find('.unread-indicator').fadeIn();
        }
    }

	// Mark messages as read 
    function markMessagesAsRead(senderId) {
        $.ajax({
            url: '/profile-mark-messages-read',
            type: 'POST',
            data: {
                sender_id: senderId,
                profile_user_id: authId, // Profile user ID 
                _token: '{{ csrf_token() }}'
            },
            success: function(response) {
                console.log('Messages marked as read for user:', senderId);
                
                // Remove notification indicators
                const chatUser = $(`.chat-user[data-id="${senderId}"]`);
                chatUser.removeClass('unread');
                chatUser.find('.unread-count-badge').hide().text('0');
                
                // Update the data attribute
                chatUser.attr('data-unread', '0');
            },
            error: function(xhr) {
                console.error('Error marking messages as read:', xhr);
            }
        });
    }
	
    // Listen for new messages
    window.Echo.private(`chat.${authId}`)
    .listen('.MessageSent', function(e) {
        console.log('New message received:', e);
        
        const senderId = parseInt(e.message.sender_id);
        const receiverId = parseInt(e.message.receiver_id);
        const currentRec = parseInt(currentReceiver);

        // If message is for current chat
        if (currentRec && (currentRec === senderId || currentRec === receiverId)) {
            const isSent = (senderId === parseInt(authId));
            const senderName = isSent ? 'You' : e.message.sender_name || currentReceiverName;
            addMessage(e.message.text, isSent, senderName, e.message.created_at);
        } 
        // If message is for another user, show notification
        else {
            const targetId = senderId !== parseInt(authId) ? senderId : receiverId;
          
			//showNewMessageNotification(targetId);
			//alert(targetId);
			const chatUser = $(`.chat-user[data-id="${targetId}"]`);
			
			
			const badge = $(`#unread-${targetId}`);
            const currentCount = parseInt(badge.text()) || 0;
            badge.text(currentCount + 1).show();
			
            if (chatUser.length) {

                $(`#unread-[data-id="${targetId}"]`).innerHtml('1');
            }
        }
    });

    // Load chat when user is selected
    $('.chat-user').on('click', function() {
        // Remove active class from all users
        $('.chat-user').removeClass('active');
        // Add active class to clicked user
        $(this).addClass('active');
        
        // Remove all notification indicators
        $(this).removeClass('unread');
        $(this).find('.new-message-badge').hide();
        $(this).find('.unread-indicator').hide();

        const name = $(this).data('name');
        const type = $(this).data('type');
        const photo = $(this).data('photo');
        const id = $(this).data('id');
        
        currentReceiver = {{request()->segment(3)}}//id;
        currentReceiverName = name;
		markMessagesAsRead(id);

        // Update chat header
        $('#chat-user-name').text(name);
        $('#chat-user-type').text(type + ' • Online');
        $('#chat-user-photo').attr('src', photo);

        // Show chat box, hide placeholder
        $('#chat-placeholder').hide();
        $('#chatbox').show();

        // Clear previous messages
        $('#message-list').empty();

        // Load messages only when user is clicked
        $.ajax({
            url: `/profile-get-messages/${currentReceiver}`,
            type: 'GET',
            success: function(messages) {
                console.log('Loaded messages:', messages);
                
                if (Array.isArray(messages) && messages.length > 0) {
                    messages.forEach(function(msg) {
                        console.log('Processing message:', msg);
                        
                        // Properly check if message is sent by current user
                        const isSent = parseInt(msg.sender_id) === parseInt(authId);
                        console.log('Message sender_id:', msg.sender_id, 'Auth ID:', authId, 'Is sent:', isSent);
                        
                        const senderName = isSent ? 'You' : (msg.sender_name || currentReceiverName);
                        addMessage(msg.text, isSent, senderName, msg.created_at);
                    });
                } else {
                    $('#message-list').html(`
                        <div class="text-center text-muted py-5">
                            <i class="fas fa-comment-slash fa-2x mb-3"></i>
                            <p>No messages yet. Start the conversation!</p>
                        </div>
                    `);
                }
                
                scrollToBottom();
            },
            error: function(xhr) {
                console.error('Error loading messages:', xhr);
                addMessage('Error loading messages. Please try again.', false, 'System');
            }
        });

        // Set receiver for sending messages
        $('#sendMessageBtn').data('receiver', id);
    });

    // Send message function
    function sendMessage() {
        const receiverId = {{request()->segment(3)}};//$('#sendMessageBtn').data('receiver');
        const messageInput = $('#messageInput');
        const message = messageInput.val().trim();

        if (!message || !receiverId) {
            alert('Please select a user first or enter a message');
            return;
        }

        // Add message immediately to chat (optimistic update)
        addMessage(message, true, 'You');

        // Clear input
        messageInput.val('');

        // Send to server
        $.ajax({
            url: '/profile-send-messages',
            type: 'POST',
            data: {
                receiver_id: receiverId,
                message: message,
                _token: '{{ csrf_token() }}'
            },
            success: function(response) {
                console.log('Message sent successfully');
            },
            error: function(xhr) {
                console.error('Error sending message:', xhr);
                // Remove the optimistic message if failed
                $('#message-list .message:last').remove();
                alert('Failed to send message. Please try again.');
            }
        });
    }

    // Send message events
    $('#sendMessageBtn').on('click', sendMessage);
    
    $('#messageInput').on('keypress', function(e) {
        if (e.which === 13 && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
});
</script>
@endsection