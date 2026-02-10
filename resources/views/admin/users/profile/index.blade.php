@extends('admin.layouts.master')
@section('title', 'Profiles')

@section('styles')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">
    <style>
        .page-heading {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            align-items: center;
        }

        .page-heading h2 {
            margin: 0;
            font-weight: 700;
        }

        .table-card {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #eef1f7;
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.04);
            padding: 18px;
        }

        .profile-thumb {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #e5e7eb;
        }

        .badge-pill {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 12px;
        }

        .datatable-wrap {
            overflow-x: auto;
        }
    </style>
@endsection

@section('content')
    <div class="container-fluid py-4">
        <div class="page-heading mb-3">
            <div>
                <h2>Profiles</h2>
                <p class="text-muted mb-0">All profiles for this user.</p>
            </div>
            <a href="{{ route('users.index') }}" class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Users
            </a>
        </div>

        <div class="table-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0">Profile List</h5>
                    <small class="text-muted">View profile details and open nests.</small>
                </div>
                <a href="{{ route('users.profile.create', request()->route('userid')) }}" class="btn btn-primary btn-sm">
                    <i class="fa-solid fa-plus"></i> Create Profile
                </a>
            </div>
            <div class="table-responsive datatable-wrap">
                <table class="table table-hover align-middle" id="profilesTable">
                    <thead class="table-light">
                        <tr>
                            <th style="width:70px;">S.N</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Privacy</th>
                            <th>Photo</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($users as $profile)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td class="fw-semibold">{{ $profile->name }}</td>
                                <td><span class="badge-pill bg-primary-subtle text-primary">{{ $profile->type }}</span></td>
                                <td><span
                                        class="badge-pill bg-info-subtle text-info">{{ ucfirst($profile->privacy) }}</span>
                                </td>
                                <td>
                                    @if ($profile->photo)
                                        <img src="{{ asset($profile->photo) }}" alt="{{ $profile->name }}"
                                            class="profile-thumb">
                                    @else
                                        <span class="text-muted">No photo</span>
                                    @endif
                                </td>
                                <td class="text-end">
                                    <a href="{{ route('users.profile.edit', $profile->id) }}"
                                        class="btn btn-sm btn-outline-warning">
                                        <i class="fa-regular fa-pen-to-square"></i>
                                    </a>
                                    <a href="{{ route('users.nest.index', $profile->id) }}"
                                        class="btn btn-sm btn-outline-primary">
                                        <i class="fa-regular fa-layer-group"></i> Nest
                                    </a>
                                    <form action="{{ route('users.profile.destroy', $profile->id) }}" method="POST"
                                        class="d-inline">
                                        @csrf
                                        @method('DELETE')
                                        <button onclick="return confirm('Are you sure?')"
                                            class="btn btn-sm btn-outline-danger">
                                            <i class="fa-regular fa-trash"></i>
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
        $(function() {
            $('#profilesTable').DataTable({
                responsive: true,
                autoWidth: false,
                pageLength: 10,
                lengthChange: false,
                columnDefs: [{
                    targets: -1,
                    orderable: false,
                    searchable: false
                }],
                language: {
                    search: '',
                    searchPlaceholder: 'Search profiles...',
                    paginate: {
                        previous: '<',
                        next: '>'
                    }
                }
            });
        });
    </script>
@endsection
