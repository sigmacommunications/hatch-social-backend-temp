@extends('admin.layouts.master')
@section('title', 'Profiles Details')
@section('content')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">

    <div class="container-fluid py-3">
        <div class="d-flex flex-wrap justify-content-between align-items-start gap-3 mb-3">
            <div class="d-flex align-items-center gap-3">
                <div style="width:70px;height:70px; border-radius:14px; overflow:hidden; box-shadow:0 8px 18px rgba(0,0,0,.12);">
                    @if ($profile->photo)
                        <img src="{{ asset($profile->photo) }}" alt="{{ $profile->name }}" style="width:100%; height:100%; object-fit:cover;">
                    @else
                        @php
                            $initials = collect(explode(' ', $profile->name ?? 'U'))
                                ->map(fn($n) => strtoupper(substr($n, 0, 1)))
                                ->take(2)
                                ->join('');
                        @endphp
                        <div class="d-flex align-items-center justify-content-center h-100 text-white fw-bold"
                            style="background:linear-gradient(135deg,#6a11cb,#2575fc);">
                            {{ $initials }}
                        </div>
                    @endif
                </div>
                <div>
                    <h4 class="mb-1">{{ $profile->name ?? 'Profile' }}</h4>
                    <div class="text-muted small">{{ $profile->email ?? 'No email set' }}</div>
                    <span class="badge bg-light text-secondary border mt-1">{{ $profile->privacy ?? 'private' }}</span>
                </div>
            </div>
            <div class="d-flex flex-wrap gap-2">
                <a href="{{ route('admin.profiles.index') }}" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left"></i> Back
                </a>
                <a href="{{ route('admin.profiles.edit', $profile) }}" class="btn btn-primary">
                    <i class="fa-regular fa-pen-to-square"></i> Edit
                </a>
                <a href="{{ route('admin.profiles.create') }}" class="btn btn-success">
                    <i class="fa-solid fa-circle-plus"></i> New Profile
                </a>
                <form action="{{ route('admin.profiles.destroy', $profile) }}" method="POST" class="d-inline">
                    @csrf
                    @method('DELETE')
                    <button type="button" class="btn btn-danger" data-delete-confirm data-name="{{ $profile->name }}">
                        <i class="fa-regular fa-trash-can"></i> Delete
                    </button>
                </form>
            </div>
        </div>

        <div class="member">
            <div class="inner-div">
                <div class="search-box">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <button id="button-addon2" type="submit" class="btn btn-link text-warning">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                        <input type="search" placeholder="Search..." aria-describedby="button-addon2" class="form-control border-0 bg-light">
                    </div>
                </div>
            </div>

            <div class="membership-main">
                <div class="nest-main">
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-owner" role="tabpanel" aria-labelledby="nav-owner-tab">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0">Communities</h6>
                                <a href="{{ route('nests.create', ['profile_id' => $profile->id]) }}" class="btn btn-sm btn-outline-success">
                                    <i class="fa-solid fa-circle-plus me-1"></i> Add Community
                                </a>
                            </div>

                            <table class="table table-striped align-middle" id="communitiesTable" style="width:100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>S.N</th>
                                        <th>Name</th>
                                        <th>Membership</th>
                                        <th>Joining Cost</th>
                                        <th>App Service Cost</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($communities as $community)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>{{ $community->title }}</td>
                                            <td>
                                                @if (strtolower($community->membership_cost) === 'yes')
                                                    <span class="badge bg-success">Yes</span>
                                                @elseif (strtolower($community->membership_cost) === 'no')
                                                    <span class="badge bg-danger">No</span>
                                                @else
                                                    <span class="badge bg-secondary">{{ ucfirst($community->membership_cost ?? 'N/A') }}</span>
                                                @endif
                                            </td>
                                            <td>{{ $community->joining_cost }}</td>
                                            <td>{{ $community->app_service_charges }}</td>
                                            <td>
                                                @if ($community->status == 'pending')
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                @else
                                                    <span class="badge bg-info text-dark">{{ ucfirst($community->status ?? 'active') }}</span>
                                                @endif
                                            </td>
                                            <td>
                                                <div class="d-flex flex-wrap gap-1">
                                                    @if (strtolower($community->membership_cost) === 'no')
                                                        @if (empty($profile->stripe_url))
                                                            <button class="btn btn-primary btn-sm monetize-btn" data-community-id="{{ $community->id }}">
                                                                Monetize
                                                            </button>
                                                        @elseif($profile->stripe_url !== 'complete' && !empty($profile->stripe_url))
                                                            <a class="btn btn-primary btn-sm" href="{{ $profile->stripe_url }}">
                                                                Add Details
                                                            </a>
                                                        @else
                                                            <button class="btn btn-primary btn-sm monetize-btn" data-community-id="{{ $community->id }}">
                                                                Monetize
                                                            </button>
                                                        @endif
                                                    @endif

                                                    <a href="{{ route('nests.show', $community) }}" class="btn btn-outline-secondary btn-sm">
                                                        <i class="fa-regular fa-eye"></i>
                                                    </a>
                                                    <a href="{{ route('nests.edit', [$community, 'profile_id' => $profile->id]) }}" class="btn btn-outline-primary btn-sm">
                                                        <i class="fa-regular fa-pen-to-square"></i>
                                                    </a>
                                                    <form action="{{ route('nests.destroy', [$community, 'profile_id' => $profile->id]) }}" method="POST" class="d-inline">
                                                        @csrf
                                                        @method('DELETE')
                                                        <button type="button" class="btn btn-outline-danger btn-sm" data-delete-community data-name="{{ $community->title }}">
                                                            <i class="fa-regular fa-trash-can"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Global Loader -->
    <div id="global-loader"
        style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
    background:rgba(255,255,255,0.8); z-index:9999; text-align:center; padding-top:20%;">
        <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
        <p style="margin-top:10px; font-weight:bold; color:#007bff;">Processing your request...</p>
    </div>

    <!-- Stripe Card Modal -->
    <div class="modal fade" id="cardModal" tabindex="-1" aria-labelledby="cardModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Card Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="cardForm" data-profile-id="{{ request()->segment(3) }}">
                        <div id="card-element"></div>
                        <button type="submit" class="btn btn-primary mt-3 w-100">Save Card</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Membership Modal -->
    <div class="modal fade" id="membershipModal" tabindex="-1" aria-labelledby="membershipModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Set Membership Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="membershipForm">
                        <div class="mb-3">
                            <label>Membership Cost</label>
                            <select name="membership_cost" class="form-select" required>
                                <option value="">Select an option</option>
                                <option value="yes" {{ old('membership_cost', $communities->first()->membership_cost ?? '') == 'yes' ? 'selected' : '' }}>Yes</option>
                                <option value="no" {{ old('membership_cost', $communities->first()->membership_cost ?? '') == 'no' ? 'selected' : '' }}>No</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Joining Cost</label>
                            <input type="number" name="joining_cost" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Save Membership</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

@endsection


@section('scripts')
    <script src="https://js.stripe.com/v3/"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            const stripe = Stripe("{{ config('services.stripe.key') }}");
            let selectedCommunityId = null;

            let cardElement = null; // Declare cardElement here
            let profileid = $('#cardForm').data('profile-id');

            $('.monetize-btn').on('click', function() {

                const baseUrl = "{{ route('check.stripe.status', ':profileid') }}";
                const finalUrl = baseUrl.replace(':profileid', profileid);
                selectedCommunityId = $(this).data('community-id');

                $.get(finalUrl, function(response) {
                    if (response.hasCard) {
                        $('#membershipModal').modal('show');
                    } else {
                        $('#cardModal').modal('show');
                    }
                }).fail(function() {
                    alert('Error checking Stripe status');
                });
            });

            // When the Add Card modal is opened
            $('#cardModal').on('shown.bs.modal', function() {
                if (!cardElement) {
                    const elements = stripe.elements();
                    cardElement = elements.create('card');
                    cardElement.mount('#card-element');
                }
            });

            // When the modal is closed, clean up the card element
            $('#cardModal').on('hidden.bs.modal', function() {
                if (cardElement) {
                    cardElement.destroy();
                    cardElement = null;
                }
            });

            // Save Card Handler
            $('#cardForm').on('submit', function(e) {
                e.preventDefault();

                if (!cardElement) {
                    alert('Card element not initialized');
                    return;
                }
                const baseUrl = "{{ route('stripe.saveCard', ':profileid') }}";
                const finalUrl = baseUrl.replace(':profileid', profileid);

                stripe.createToken(cardElement).then(function(result) {
                    if (result.error) {
                        alert(result.error.message);
                    } else {
                        $.ajax({
                            url: finalUrl,
                            type: 'POST',
                            data: {
                                _token: '{{ csrf_token() }}',
                                stripeToken: result.token.id
                            },
                            success: function(res) {
                                if (res.success) {
                                    alert(res.message);
                                    $('#cardModal').modal('hide');
                                    window.location.href = res.url;
                                } else {
                                    alert('Error saving card');
                                }
                            },
                            error: function() {
                                alert('Server error saving card.');
                            }
                        });
                    }
                });
            });

            // Save Membership
            $('#membershipForm').on('submit', function(e) {
                e.preventDefault();

                const formData = $(this).serializeArray();
                formData.push({
                    name: '_token',
                    value: '{{ csrf_token() }}'
                }, {
                    name: 'community_id',
                    value: selectedCommunityId
                });

                // Show loader
                $('#global-loader').fadeIn(200);

                $.ajax({
                    url: "{{ route('stripe.saveMembership') }}",
                    type: "POST",
                    data: formData,
                    success: function(res) {
                        if (res.success) {
                            alert(res.message);
                            $('#membershipModal').modal('hide');
                            location.reload();
                        } else {
                            alert(res.message || 'Something went wrong.');
                        }
                    },
                    error: function(xhr) {
                        console.error(xhr.responseJSON);
                        alert('Server error saving membership.');
                    },
                    complete: function() {
                        // Hide loader after request
                        $('#global-loader').fadeOut(200);
                    }
                });
            });

            $('[data-delete-confirm]').on('click', function() {
                const name = $(this).data('name') || 'this profile';
                if (confirm(`Delete ${name}? This cannot be undone.`)) {
                    $(this).closest('form').submit();
                }
            });

            $('[data-delete-community]').on('click', function() {
                const name = $(this).data('name') || 'this community';
                if (confirm(`Delete ${name}? This cannot be undone.`)) {
                    $(this).closest('form').submit();
                }
            });

            $('#communitiesTable').DataTable({
                pageLength: 10,
                order: [[0, 'asc']],
                columnDefs: [
                    { orderable: false, targets: [6] }
                ]
            });
        });
    </script>
@endsection
