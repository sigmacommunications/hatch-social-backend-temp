@extends('admin.layouts.master')
@section('title', 'Interests')

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

        .badge-pill {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 12px;
        }

        .datatable-wrap {
            overflow-x: auto;
        }

        .img-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
        }
    </style>
@endsection

@section('content')
    <div class="container-fluid py-4">
        <div class="page-heading mb-3">
            <div>
                <h2>Interests</h2>
                <p class="text-muted mb-0">All interests in the system.</p>
            </div>
            <a href="{{ route('interests.create') }}" class="btn btn-primary btn-sm">
                <i class="fa-solid fa-plus"></i> Add Interest
            </a>
        </div>

        <div class="table-card">
            <div class="table-responsive datatable-wrap">
                @if (count($interests) > 0)
                    <table class="table table-hover align-middle" id="interestsTable">
                        <thead class="table-light">
                            <tr>
                                <th>S.N.</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Photo</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($interests as $interest)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $interest->name }}</td>
                                    <td><span class="badge-pill bg-primary-subtle text-primary">{{ $interest->type }}</span>
                                    </td>
                                    <td>
                                        @if ($interest->image)
                                            <img src="{{ asset('storage/' . $interest->image) }}" class="img-thumb"
                                                alt="{{ $interest->name }}">
                                        @else
                                            <span class="text-muted">No image</span>
                                        @endif
                                    </td>
                                    {{-- <td>
                                        @if ($interest->status == 'active')
                                            <span
                                                class="badge-pill bg-success-subtle text-success">{{ ucfirst($interest->status) }}</span>
                                        @else
                                            <span
                                                class="badge-pill bg-warning-subtle text-warning">{{ ucfirst($interest->status) }}</span>
                                        @endif
                                    </td> --}}
                                    <td class="text-end">
                                        <a href="{{ route('interests.edit', $interest->id) }}"
                                            class="btn btn-sm btn-outline-warning">
                                            <i class="fa-regular fa-pen-to-square"></i>
                                        </a>
                                        {{-- <form action="{{ route('interests.destroy', $interest->id) }}" method="POST"
                                            class="d-inline">
                                            @csrf
                                            @method('DELETE')
                                            <button class="btn btn-sm btn-outline-danger deleteBtn" type="button"
                                                data-id="{{ $interest->id }}">
                                                <i class="fa-regular fa-trash"></i>
                                            </button>
                                        </form> --}}
                                        <!-- ✅ Form ko thoda change karo -->
                                        <button type="button" class="btn btn-sm btn-outline-danger deleteBtn"
                                            data-id="{{ $interest->id }}">
                                            <i class="fa-regular fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                @else
                    <h6 class="text-center text-muted">No interests found. Please create some interests.</h6>
                @endif
            </div>
        </div>
    </div>
@endsection

@section('scripts')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>

    <script>
        $(function() {
            $('#interestsTable').DataTable({
                responsive: true,
                autoWidth: false,
                pageLength: 10,
                lengthChange: false,
                columnDefs: [{
                    targets: -1,
                    orderable: false,
                    searchable: false
                }]
            });

            // ✅ SweetAlert 2 Delete Confirmation (Updated)
            $(document).on('click', '.deleteBtn', function(e) {
                e.preventDefault();

                let interestId = $(this).data('id');
                let csrfToken = $('meta[name="csrf-token"]').attr('content');

                Swal.fire({
                    title: 'Are you sure?',
                    text: "Once deleted, you will not be able to recover this interest!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        // ✅ AJAX Request for Delete
                        $.ajax({
                            url: "{{ route('interests.destroy', ':id') }}".replace(':id',
                                interestId),
                            type: 'DELETE',
                            data: {
                                _token: csrfToken
                            },
                            success: function(response) {
                                if (response.success) {
                                    Swal.fire(
                                        'Deleted!',
                                        'Interest has been deleted.',
                                        'success'
                                    ).then(() => {
                                        location.reload(); // Refresh the page
                                    });
                                } else {
                                    Swal.fire(
                                        'Error!',
                                        response.message || 'Something went wrong.',
                                        'error'
                                    );
                                }
                            },
                            error: function(xhr) {
                                Swal.fire(
                                    'Error!',
                                    xhr.responseJSON?.message ||
                                    'Failed to delete.',
                                    'error'
                                );
                            }
                        });
                    }
                });
            });
        });
    </script>
@endsection
