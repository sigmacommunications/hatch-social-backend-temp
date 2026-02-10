@extends('admin.layouts.master')
@section('title', 'Chat')
@section('content')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">
    <style>
        .chat-card {
            height: 75vh;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            border: 1px solid #e9ecef;
        }

        .chat-sidebar {
            border-right: 1px solid #e9ecef;
            overflow-y: auto;
            max-height: 75vh;
        }

        .chat-sidebar .item {
            padding: 12px 14px;
            cursor: pointer;
            border-bottom: 1px solid #f1f3f5;
            transition: background 0.15s;
        }

        .chat-sidebar .item:hover {
            background: #f8f9fa;
        }

        .chat-sidebar .item.active {
            background: #e8f2ff;
            border-left: 3px solid #0d6efd;
        }

        .chat-body {
            display: flex;
            flex-direction: column;
            height: 75vh;
        }

        .message-stream {
            flex: 1;
            overflow-y: auto;
            padding: 18px;
            background: #f7f9fb;
        }

        .bubble {
            max-width: 78%;
            padding: 10px 14px;
            border-radius: 14px;
            margin-bottom: 12px;
            position: relative;
        }

        .bubble.me {
            background: #0d6efd;
            color: #fff;
            margin-left: auto;
            border-bottom-right-radius: 6px;
        }

        .bubble.them {
            background: #fff;
            border: 1px solid #e9ecef;
            margin-right: auto;
            border-bottom-left-radius: 6px;
        }

        .bubble small {
            display: block;
            opacity: .75;
            margin-top: 4px;
        }

        .composer {
            border-top: 1px solid #e9ecef;
            padding: 12px 14px;
            background: #fff;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
        }

        .stat-tile {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 16px;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
        }

        .table-card {
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            border: 1px solid #e9ecef;
        }
    </style>

    <div class="container-fluid px-0">
        {{-- <div class="row g-3 mb-3">
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-tile d-flex align-items-center justify-content-between">
                    <div>
                        <p class="mb-1 text-muted small">Total Messages</p>
                        <h4 class="mb-0 fw-bold">{{ $messageStats['total'] ?? 0 }}</h4>
                    </div>
                    <span class="badge bg-primary rounded-pill px-3 py-2"><i class="fa fa-comments"></i></span>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-tile d-flex align-items-center justify-content-between">
                    <div>
                        <p class="mb-1 text-muted small">Unread</p>
                        <h4 class="mb-0 fw-bold">{{ $messageStats['unread'] ?? 0 }}</h4>
                    </div>
                    <span class="badge bg-warning text-dark rounded-pill px-3 py-2"><i
                            class="fa fa-envelope-open"></i></span>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-tile d-flex align-items-center justify-content-between">
                    <div>
                        <p class="mb-1 text-muted small">Today</p>
                        <h4 class="mb-0 fw-bold">{{ $messageStats['today'] ?? 0 }}</h4>
                    </div>
                    <span class="badge bg-success rounded-pill px-3 py-2"><i class="fa fa-calendar-day"></i></span>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-tile d-flex align-items-center justify-content-between">
                    <div>
                        <p class="mb-1 text-muted small">Unique Senders</p>
                        <h4 class="mb-0 fw-bold">{{ $messageStats['unique_senders'] ?? 0 }}</h4>
                    </div>
                    <span class="badge bg-info text-dark rounded-pill px-3 py-2"><i class="fa fa-users"></i></span>
                </div>
            </div>
        </div> --}}

        <div class="card chat-card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-0">Live Chat</h5>
                    <small class="text-muted">Pick a user and start talking</small>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-outline-secondary btn-sm" id="refreshList"><i class="fa fa-rotate"></i>
                        Refresh</button>
                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#composeModal"><i
                            class="fa fa-plus"></i> New Message</button>
                </div>
            </div>
            <div class="row g-0 h-100">
                <div class="col-12 col-lg-4 chat-sidebar" id="chatList">
                    <div class="p-3 border-bottom">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-white"><i class="fa fa-search"></i></span>
                            <input type="text" class="form-control" id="userSearch" placeholder="Search user">
                        </div>
                    </div>
                    @foreach ($profiles as $profile)
                        <div class="item d-flex align-items-center" data-id="{{ $profile->id }}"
                            data-name="{{ $profile->name }}" data-type="{{ $profile->type }}"
                            data-photo="{{ $profile->photo ? '/' . $profile->photo : 'https://via.placeholder.com/80?text=User' }}">
                            <img class="avatar me-2"
                                src="{{ $profile->photo ? '/' . $profile->photo : 'https://via.placeholder.com/80?text=User' }}"
                                alt="{{ $profile->name }}">
                            <div class="flex-grow-1">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-semibold">{{ $profile->name }}</span>
                                    @if ($profile->unread_count > 0)
                                        <span class="badge bg-danger">{{ $profile->unread_count }}</span>
                                    @endif
                                </div>
                                <small class="text-muted">{{ ucfirst($profile->type) }}</small>
                            </div>
                        </div>
                    @endforeach
                </div>
                <div class="col-12 col-lg-8 chat-body">
                    <div class="d-flex align-items-center justify-content-between p-3 border-bottom bg-white">
                        <div class="d-flex align-items-center">
                            <img id="chatUserPhoto" class="avatar me-2" src="https://via.placeholder.com/80?text=User"
                                alt="User">
                            <div>
                                <h6 class="mb-0" id="chatUserName">Select a user</h6>
                                <small class="text-muted" id="chatUserMeta">No conversation selected</small>
                            </div>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-secondary btn-sm" id="clearChat"><i
                                    class="fa fa-eraser"></i></button>
                        </div>
                    </div>
                    <div class="message-stream" id="messageStream">
                        <div class="text-center text-muted py-5">
                            <i class="fa fa-comments fa-2x mb-3"></i>
                            <p class="mb-0">Pick a user to start chatting</p>
                        </div>
                    </div>
                    <div class="composer d-flex align-items-center gap-2">
                        <input type="text" class="form-control" id="messageInput" placeholder="Type a message..."
                            autocomplete="off">
                        <button class="btn btn-primary" id="sendMessage"><i class="fa fa-paper-plane"></i></button>
                    </div>
                </div>
            </div>
        </div>

        {{-- <div class="card table-card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div>
                <h5 class="mb-0">Message Manager</h5>
                <small class="text-muted">Inline edit / delete for audit & cleanup</small>
            </div>
            <button class="btn btn-outline-primary btn-sm" id="reloadTable"><i class="fa fa-rotate"></i> Reload</button>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle" id="messagesTable" style="width:100%">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Sender</th>
                            <th>Receiver</th>
                            <th>Message</th>
                            <th>Read?</th>
                            <th>Created</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div> --}}
    </div>

    <!-- Compose Modal -->
    <div class="modal fade" id="composeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Send Message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Send to</label>
                        <select class="form-select" id="composeReceiver">
                            <option value="">Select user</option>
                            @foreach ($allProfiles as $user)
                                <option value="{{ $user->id }}">{{ $user->name }} ({{ $user->type }})</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Message</label>
                        <textarea class="form-control" id="composeText" rows="3" placeholder="Write something..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="composeSend">Send</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editMessageId">
                    <div class="mb-3">
                        <label class="form-label">Message</label>
                        <textarea class="form-control" id="editMessageText" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveEdit">Save</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-danger">Delete Message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-0">Are you sure you want to delete this message?</p>
                    <input type="hidden" id="deleteMessageId">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDelete">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        $(function() {
            const authId = parseInt("{{ Auth::id() }}", 10);
            let currentReceiver = null;
            const routes = {
                list: "{{ route('admin.chat.messages.table') }}",
                send: "{{ route('send.messages') }}",
                getMessages: "{{ url('/get-messages') }}",
                update: "{{ url('/chat/messages') }}",
                destroy: "{{ url('/chat/messages') }}",
            };

            /* Conversation list filter */
            $('#userSearch').on('input', function() {
                const term = $(this).val().toLowerCase();
                $('#chatList .item').each(function() {
                    $(this).toggle($(this).data('name').toLowerCase().includes(term));
                });
            });

            /* Select conversation */
            $('#chatList').on('click', '.item', function() {
                $('#chatList .item').removeClass('active');
                $(this).addClass('active');
                const id = $(this).data('id');
                const name = $(this).data('name');
                const type = $(this).data('type');
                const photo = $(this).data('photo');
                currentReceiver = id;
                $('#chatUserName').text(name);
                $('#chatUserMeta').text(type);
                $('#chatUserPhoto').attr('src', photo);
                loadMessages(id);
            });

            function renderBubble(text, isMe, timestamp) {
                const time = timestamp ? new Date(timestamp).toLocaleTimeString([], {
                    hour: '2-digit',
                    minute: '2-digit'
                }) : '';
                return `<div class="bubble ${isMe ? 'me' : 'them'}">
                        <div>${text}</div>
                        <small>${time}</small>
                    </div>`;
            }

            function loadMessages(receiverId) {
                $('#messageStream').html('<div class="text-center text-muted py-4">Loading...</div>');
                $.get(`${routes.getMessages}/${receiverId}`, function(messages) {
                    if (!messages || !messages.length) {
                        $('#messageStream').html(
                            '<div class="text-center text-muted py-5"><i class="fa fa-comment-slash fa-2x mb-3"></i><p class="mb-0">No messages yet.</p></div>'
                        );
                        return;
                    }
                    const html = messages.map(m => renderBubble(m.text, parseInt(m.sender_id) === authId, m
                        .created_at)).join('');
                    $('#messageStream').html(html);
                    scrollToBottom();
                }).fail(() => {
                    $('#messageStream').html(
                        '<div class="text-danger text-center py-4">Failed to load messages.</div>');
                });
            }

            function scrollToBottom() {
                const el = document.getElementById('messageStream');
                if (el) el.scrollTop = el.scrollHeight;
            }

            $('#sendMessage').on('click', sendMessage);
            $('#messageInput').on('keypress', function(e) {
                if (e.which === 13 && !e.shiftKey) {
                    e.preventDefault();
                    sendMessage();
                }
            });

            function sendMessage() {
                const text = $('#messageInput').val().trim();
                if (!currentReceiver || !text) return;
                $('#messageStream').append(renderBubble(text, true, new Date().toISOString()));
                scrollToBottom();
                $('#messageInput').val('');
                $.post(routes.send, {
                    _token: '{{ csrf_token() }}',
                    receiver_id: currentReceiver,
                    message: text
                });
            }

            /* Compose modal send */
            $('#composeSend').on('click', function() {
                const receiver = $('#composeReceiver').val();
                const text = $('#composeText').val().trim();
                if (!receiver || !text) return alert('Select user and enter message.');
                $.post(routes.send, {
                        _token: '{{ csrf_token() }}',
                        receiver_id: receiver,
                        message: text
                    })
                    .done(() => {
                        $('#composeText').val('');
                        $('#composeReceiver').val('');
                        $('#composeModal').modal('hide');
                    });
            });

            $('#clearChat').on('click', function() {
                $('#messageStream').empty().append(
                    '<div class="text-muted text-center py-4">Chat cleared from view.</div>');
            });

            /* DataTable for CRUD */
            const table = $('#messagesTable').DataTable({
                processing: true,
                serverSide: false,
                ajax: routes.list,
                columns: [{
                        data: 'id'
                    },
                    {
                        data: 'sender',
                        render: data => data || '—'
                    },
                    {
                        data: 'receiver',
                        render: data => data || '—'
                    },
                    {
                        data: 'text',
                        render: data =>
                            `<span class="text-truncate d-inline-block" style="max-width:280px" title="${data}">${data}</span>`
                    },
                    {
                        data: 'is_read',
                        render: val => val ? '<span class="badge bg-success">Yes</span>' :
                            '<span class="badge bg-secondary">No</span>'
                    },
                    {
                        data: 'created_at'
                    },
                    {
                        data: null,
                        orderable: false,
                        searchable: false,
                        render: function(data, type, row) {
                            const safeText = (row.text || '').replace(/</g, '&lt;').replace(/>/g,
                                '&gt;').replace(/\"/g, '&quot;');
                            return `<div class="text-end">
                        <button class="btn btn-sm btn-outline-primary me-1 editRow" data-id="${row.id}" data-text="${safeText}"><i class="fa fa-pen"></i></button>
                        <button class="btn btn-sm btn-outline-danger deleteRow" data-id="${row.id}"><i class="fa fa-trash"></i></button>
                    </div>`;
                        }
                    },
                ]
            });

            $('#reloadTable').on('click', () => table.ajax.reload(null, false));
            $('#refreshList').on('click', () => location.reload());

            $('#messagesTable').on('click', '.editRow', function() {
                $('#editMessageId').val($(this).data('id'));
                $('#editMessageText').val($(this).data('text'));
                $('#editModal').modal('show');
            });

            $('#saveEdit').on('click', function() {
                const id = $('#editMessageId').val();
                const text = $('#editMessageText').val().trim();
                if (!text) return;
                $.ajax({
                    url: `${routes.update}/${id}`,
                    method: 'PUT',
                    data: {
                        _token: '{{ csrf_token() }}',
                        text
                    },
                    success: function() {
                        $('#editModal').modal('hide');
                        table.ajax.reload(null, false);
                    },
                    error: function() {
                        alert('Could not update message');
                    }
                });
            });

            $('#messagesTable').on('click', '.deleteRow', function() {
                $('#deleteMessageId').val($(this).data('id'));
                $('#deleteModal').modal('show');
            });

            $('#confirmDelete').on('click', function() {
                const id = $('#deleteMessageId').val();
                $.ajax({
                    url: `${routes.destroy}/${id}`,
                    method: 'DELETE',
                    data: {
                        _token: '{{ csrf_token() }}'
                    },
                    success: function() {
                        $('#deleteModal').modal('hide');
                        table.ajax.reload(null, false);
                    },
                    error: function() {
                        alert('Delete failed');
                    }
                });
            });
        });
    </script>
@endsection
