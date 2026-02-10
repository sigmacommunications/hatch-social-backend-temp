@extends('admin.layouts.master')
@section('title', 'Reports - Admin Panel')

@section('styles')
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">
<style>
    .table-card {
        background: #fff;
        border-radius: 14px;
        padding: 18px;
    }
</style>
@endsection

@section('content')
<div class="container-fluid py-4">

    <div class="mb-3">
        <h2>Reports list</h2>
        <p class="text-muted mb-0">All reported posts</p>
    </div>

    <div class="table-card">
        @if(count($reports))
        <table class="table table-hover align-middle" id="reportsTable">
            <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>Reported By</th>
                    <th>Post Creator</th>
                    <th>Caption</th>
                    <th>Reason</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th class="text-end">Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach($reports as $report)
                <tr>
                    <td>{{ $loop->iteration }}</td>

                    <td>{{ $report->profile->name ?? 'N/A' }}</td>

                    <td>{{ optional(optional($report->post)->profile)->name ?? 'N/A' }}</td>

                    <td>{{ Str::limit(optional($report->post)->caption, 20) }}</td>

                    <td>{{ $report->reason }}</td>

                    <td>
                        <span class="badge bg-warning">{{ ucfirst($report->type) }}</span>
                    </td>

                    <td>
                        @if($report->post)
                        <button
                            class="btn btn-sm toggle-status-btn {{ $report->post->status == 'active' ? 'btn-success' : 'btn-secondary' }}"
                            data-post-id="{{ $report->post->id }}">
                            {{ ucfirst($report->post->status) }}
                        </button>
                        @else
                        <span class="badge bg-danger">Post Deleted</span>
                        @endif
                    </td>

                    <td class="text-end">
                        @if($report->post)
                        <button class="btn btn-sm btn-info view-post-btn"
                            data-community-id="{{ $report->post->community_id }}"
                            data-profile-id="{{ $report->profile_id }}">
                            Details
                        </button>
                        @endif

                        <button class="btn btn-sm btn-danger delete-report-btn"
                            data-report-id="{{ $report->id }}">
                            Delete
                        </button>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        @else
            <p class="text-center text-muted">No reports found</p>
        @endif
    </div>
</div>

<!-- DETAILS MODAL -->
<div class="modal fade" id="postDetailModal" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Post Details</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="postDetailContent">
                <p class="text-center text-muted">Loading...</p>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>

<script>
$(function () {
    $('#reportsTable').DataTable({
        responsive: true,
        pageLength: 10,
        lengthChange: false,
        columnDefs: [{ targets: -1, orderable: false }]
    });
});

/* TOGGLE STATUS */
$('#reportsTable').on('click', '.toggle-status-btn', function () {
    let btn = $(this);
    let postId = btn.data('post-id');

    $.post("{{ url('admin/posts') }}/" + postId + "/toggle-status", {
        _token: "{{ csrf_token() }}"
    }, function (res) {
        btn.toggleClass('btn-success btn-secondary')
           .text(res.status.charAt(0).toUpperCase() + res.status.slice(1));
    });
});

/* DELETE REPORT */
$('#reportsTable').on('click', '.delete-report-btn', function () {
    let btn = $(this);
    let id = btn.data('report-id');

    if (!confirm('Delete this report?')) return;

    $.ajax({
        url: "{{ url('reports') }}/" + id,
        type: "DELETE",
        data: { _token: "{{ csrf_token() }}" },
        success: function () {
            btn.closest('tr').fadeOut(300, function () {
                $(this).remove();
            });
        }
    });
});

</script>
<script>
$('#reportsTable').on('click', '.view-post-btn', function () {

    let postId    = $(this).data('post-id');
    let profileId = $(this).data('profile-id');

    if (!postId) {
        toastr.warning('Post not available');
        return;
    }

    $('#postDetailModal').modal('show');
    $('#postDetailContent').html('<p class="text-center text-muted">Loading...</p>');

    $.ajax({
        url: "{{ url('/post-detail') }}/" + postId,
        type: "GET",
        data: {
            profile_id: profileId
        },
        success: function (res) {

            if (!res.success || !res.post_info) {
                $('#postDetailContent').html('<p class="text-center text-muted">No data found</p>');
                return;
            }

            let post = res.post_info;
            let html = '';

            html += `
                <div class="card shadow-sm">
                    <div class="card-body">

                        <div class="mb-2">
                            <strong>Posted By:</strong>
                            ${post.profile_info?.name ?? 'N/A'}
                        </div>

                        <div class="mb-2">
                            <strong>Caption:</strong>
                            <p>${post.caption ?? 'N/A'}</p>
                        </div>

                        <div class="mb-2">
                            <strong>Status:</strong>
                            <span class="badge bg-${post.status === 'active' ? 'success' : 'secondary'}">
                                ${post.status}
                            </span>
                        </div>

                        <div class="mb-3">
                            <strong>Reactions:</strong><br>
                            👍 ${post.thumb_count}
                            😂 ${post.haha_count}
                            ❤️ ${post.love_count}
                            😮 ${post.surprised_count}
                            😢 ${post.sad_count}
                        </div>
            `;

            /* Images */
            if (post.post_images && post.post_images.length > 0) {
                html += `<div class="mb-3"><strong>Images:</strong><br>`;
                post.post_images.forEach(img => {
                    html += `<img src="${img.name}" class="img-thumbnail me-2 mb-2" width="120">`;
                });
                html += `</div>`;
            }

            /* Videos */
            if (post.post_videos && post.post_videos.length > 0) {
                html += `<div class="mb-3"><strong>Videos:</strong><br>`;
                post.post_videos.forEach(video => {
                    html += `
                        <video controls width="220" class="me-2 mb-2">
                            <source src="${video.video}">
                        </video>
                    `;
                });
                html += `</div>`;
            }

            /* Comments */
            if (post.comments && post.comments.length > 0) {
                html += `<hr><strong>Comments</strong><ul class="ps-3">`;
                post.comments.forEach(c => {
                    html += `
                        <li class="mb-1">
                            <strong>${c.profile_info?.name ?? 'User'}:</strong>
                            ${c.comment}
                        </li>
                    `;
                });
                html += `</ul>`;
            }

            html += `
                    </div>
                </div>
            `;

            $('#postDetailContent').html(html);
        },
        error: function () {
            $('#postDetailContent').html(
                '<p class="text-danger text-center">Failed to load post detail</p>'
            );
        }
    });
});
</script>

@endsection
