@extends('admin.layouts.master')
@section('title', 'Users')

@section('styles')
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">
<style>
    .page-heading {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
    }
    .page-heading h2 {
        font-weight: 700;
        margin: 0;
    }
    .stat-card {
        background: linear-gradient(135deg, #f8f9ff, #ffffff);
        border: 1px solid #eef1f7;
        border-radius: 14px;
        padding: 16px;
        display: flex;
        align-items: center;
        gap: 14px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
        height: 100%;
    }
    .stat-icon {
        width: 48px;
        height: 48px;
        display: grid;
        place-items: center;
        border-radius: 12px;
        color: #fff;
        font-size: 20px;
    }
    .stat-icon.users { background: #4f46e5; }
    .stat-icon.active { background: #0ea5e9; }
    .stat-icon.revenue { background: #22c55e; }
    .stat-icon.calendar { background: #f59e0b; }
    .stat-title {
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: .08em;
        color: #6b7280;
        margin: 0;
    }
    .stat-value {
        font-size: 26px;
        font-weight: 700;
        color: #0f172a;
        margin: 2px 0 0;
    }
    .filter-bar {
        display: flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
    }
    .search-input { max-width: 320px; }
    .table-card {
        background: #fff;
        border-radius: 14px;
        border: 1px solid #eef1f7;
        box-shadow: 0 12px 32px rgba(0, 0, 0, 0.04);
        padding: 18px;
    }
    .datatable-wrap {
        overflow-x: auto;
    }
    .dataTables_wrapper {
        width: 100%;
    }
    .table thead th {
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: .05em;
        color: #6b7280;
        border-bottom: 1px solid #e5e7eb;
    }
    .table td, .table th {
        vertical-align: middle;
        white-space: nowrap;
    }
    .badge-status {
        padding: 6px 10px;
        border-radius: 30px;
        font-size: 12px;
    }
    .badge-status.active { background: rgba(34, 197, 94, 0.12); color: #166534; }
    .badge-status.inactive { background: rgba(239, 68, 68, 0.12); color: #991b1b; }
    .actions-gap > * {
        margin-right: 6px;
    }
    @media (max-width: 991px) {
        .page-heading { flex-direction: column; align-items: flex-start; }
        .filter-bar { width: 100%; }
        .search-input { width: 100%; max-width: none; }
        .table-responsive { margin-top: 12px; }
    }
</style>
@endsection

@section('content')
<div class="container-fluid py-4">
    <div class="page-heading mb-3">
        <div>
            <h2>Users</h2>
            <p class="text-muted mb-0">Manage accounts, view profiles, and keep an eye on platform activity.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="{{ route('users.create') }}" class="btn btn-primary px-3">
                <i class="fa-solid fa-plus me-1"></i> Add User
            </a>
        </div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon users"><i class="fa-solid fa-users"></i></div>
                <div>
                    <p class="stat-title">Total Users</p>
                    <div class="stat-value">{{ number_format($totalUsers ?? $users->count()) }}</div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon active"><i class="fa-solid fa-user-check"></i></div>
                <div>
                    <p class="stat-title">Active Users</p>
                    <div class="stat-value">{{ number_format($activeUsers ?? 0) }}</div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon revenue"><i class="fa-solid fa-wallet"></i></div>
                <div>
                    <p class="stat-title">Revenue (This Month)</p>
                    <div class="stat-value">${{ number_format($monthlyRevenue ?? 0, 2) }}</div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon calendar"><i class="fa-regular fa-calendar-check"></i></div>
                <div>
                    <p class="stat-title">Calendar / Events</p>
                    <div class="stat-value">{{ number_format($upcomingEvents ?? 0) }}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="table-card">
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
            <div>
                <h5 class="mb-0">All Users</h5>
                <small class="text-muted">Search, edit, or remove users from the list below.</small>
            </div>
            <div class="filter-bar">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass"></i></span>
                    <input type="search" class="form-control search-input border-start-0" placeholder="Search users..." id="userSearch">
                </div>
            </div>
        </div>

        @if (session('success'))
            <div class="alert alert-success">{{ session('success') }}</div>
        @endif
        @if (session('error'))
            <div class="alert alert-danger">{{ session('error') }}</div>
        @endif

        <div class="table-responsive datatable-wrap">
            <table class="table align-middle mb-0" id="usersTable">
                <thead>
                    <tr>
                        <th style="width: 70px;">No.</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Plan</th>
                        <th>Status</th>
                        <th>Joined</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($users as $user)
                        <tr class="user-row">
                            <td>{{ ++$i }}</td>
                            <td class="fw-semibold">{{ trim("{$user->first_name} {$user->last_name}") ?: 'Unnamed' }}</td>
                            <td>{{ $user->email }}</td>
                            <td>{{ $user->current_plan ?? '—' }}</td>
                            <td>
                                <span class="badge-status {{ $user->status === 'active' ? 'active' : 'inactive' }}">
                                    {{ ucfirst($user->status ?? 'inactive') }}
                                </span>
                            </td>
                            <td>{{ optional($user->created_at)->format('M d, Y') }}</td>
                            <td class="text-end actions-gap">
                                <a href="{{ route('users.profile.index', $user->id) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="fa-regular fa-id-badge"></i> Profile
                                </a>
                                <a href="{{ route('users.edit', $user->id) }}" class="btn btn-sm btn-outline-secondary">
                                    <i class="fa-regular fa-pen-to-square"></i> Edit
                                </a>
                                <form action="{{ route('users.destroy', $user->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('Delete this user?');">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                        <i class="fa-regular fa-trash"></i> Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
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
        const table = $('#usersTable').DataTable({
            responsive: true,
            autoWidth: false,
            pageLength: 10,
            lengthChange: false,
            order: [[0, 'asc']],
            columnDefs: [
                { targets: -1, orderable: false, searchable: false }
            ],
            language: {
                search: '',
                searchPlaceholder: 'Search users...',
                paginate: { previous: '<', next: '>' }
            }
        });

        $('#userSearch').on('keyup change', function () {
            table.search(this.value).draw();
        });
    });
</script>
@endsection
