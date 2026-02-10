@extends('admin.layouts.master')
@section('title', 'Packages')

@section('styles')
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">
<style>
    .page-heading {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
        margin-bottom: 2rem;
    }
    .page-heading h2 {
        font-weight: 700;
        margin: 0;
        color: #0f172a;
    }
    .page-heading p {
        color: #6b7280;
        margin: 0.25rem 0 0 0;
    }
    .stat-card {
        background: linear-gradient(135deg, #f8f9ff, #ffffff);
        border: 1px solid #eef1f7;
        border-radius: 14px;
        padding: 18px;
        display: flex;
        align-items: center;
        gap: 14px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
        height: 100%;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 28px rgba(0, 0, 0, 0.06);
    }
    .stat-icon {
        width: 54px;
        height: 54px;
        display: grid;
        place-items: center;
        border-radius: 12px;
        color: #fff;
        font-size: 22px;
        flex-shrink: 0;
    }
    .stat-icon.packages { background: linear-gradient(135deg, #4f46e5, #6366f1); }
    .stat-icon.premium { background: linear-gradient(135deg, #f59e0b, #fbbf24); }
    .stat-icon.revenue { background: linear-gradient(135deg, #22c55e, #4ade80); }
    .stat-icon.active { background: linear-gradient(135deg, #0ea5e9, #3b82f6); }
    .stat-title {
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: .08em;
        color: #6b7280;
        margin: 0;
        font-weight: 600;
    }
    .stat-value {
        font-size: 28px;
        font-weight: 800;
        color: #0f172a;
        margin: 4px 0 0;
        line-height: 1;
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
        padding: 22px;
        margin-top: 1.5rem;
    }
    .datatable-wrap {
        overflow-x: auto;
        border-radius: 10px;
    }
    .dataTables_wrapper {
        width: 100%;
    }
    .table thead th {
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: .05em;
        color: #6b7280;
        border-bottom: 2px solid #e5e7eb;
        padding: 14px 16px;
        font-weight: 700;
        background: #f8fafc;
    }
    .table td, .table th {
        vertical-align: middle;
        padding: 14px 16px;
        border-color: #f1f5f9;
    }
    .table tbody tr {
        transition: background-color 0.15s ease;
    }
    .table tbody tr:hover {
        background-color: #f8fafc;
    }
    .badge-plan {
        padding: 6px 12px;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.02em;
    }
    .badge-plan.basic { background: rgba(99, 102, 241, 0.12); color: #4f46e5; }
    .badge-plan.premium { background: rgba(245, 158, 11, 0.12); color: #d97706; }
    .badge-plan.purchase { background: rgba(22, 163, 74, 0.12); color: #166534; }
    .badge-plan.community { background: rgba(168, 85, 247, 0.12); color: #7c3aed; }
    .actions-gap > * {
        margin-right: 6px;
    }
    .price-cell {
        font-weight: 700;
        font-size: 16px;
        color: #0f172a;
    }
    .price-cell::before {
        content: '$';
        font-size: 14px;
        color: #6b7280;
        margin-right: 2px;
    }
    .description-cell {
        max-width: 300px;
        white-space: normal;
        color: #64748b;
        line-height: 1.5;
    }
    .btn-add {
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }
    @media (max-width: 991px) {
        .page-heading { flex-direction: column; align-items: flex-start; }
        .filter-bar { width: 100%; }
        .search-input { width: 100%; max-width: none; }
    }
</style>
@endsection

@section('content')
<div class="container-fluid py-4">
    <div class="page-heading">
        <div>
            <h2>Packages</h2>
            <p>Manage subscription plans, pricing, and features for your platform.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="{{ route('package.create') }}" class="btn btn-primary btn-add">
                <i class="fa-solid fa-plus"></i> Add Package
            </a>
        </div>
    </div>

    {{-- <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon packages"><i class="fa-solid fa-box-open"></i></div>
                <div>
                    <p class="stat-title">Total Packages</p>
                    <div class="stat-value">{{ number_format($totalPackages ?? $packages->count()) }}</div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon premium"><i class="fa-solid fa-crown"></i></div>
                <div>
                    <p class="stat-title">Premium Plans</p>
                    <div class="stat-value">{{ number_format($premiumPlans ?? 0) }}</div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon revenue"><i class="fa-solid fa-money-bill-wave"></i></div>
                <div>
                    <p class="stat-title">Monthly Revenue</p>
                    <div class="stat-value">${{ number_format($monthlyRevenue ?? 0, 2) }}</div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon active"><i class="fa-solid fa-rocket"></i></div>
                <div>
                    <p class="stat-title">Active Subscriptions</p>
                    <div class="stat-value">{{ number_format($activeSubscriptions ?? 0) }}</div>
                </div>
            </div>
        </div>
    </div> --}}

    <div class="table-card">
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
            <div>
                <h5 class="mb-0">All Packages</h5>
                <small class="text-muted">Manage, edit, or remove subscription packages.</small>
            </div>
            <div class="filter-bar">
                {{-- <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass"></i></span>
                    <input type="search" class="form-control search-input border-start-0" placeholder="Search packages..." id="packageSearch">
                </div> --}}
            </div>
        </div>

        @if (session('success'))
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>
                {{ session('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif
        @if (session('error'))
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i>
                {{ session('error') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        <div class="table-responsive datatable-wrap">
            <table class="table align-middle mb-0" id="packagesTable">
                <thead>
                    <tr>
                        <th style="width: 60px;">#</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Stripe ID</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($packages as $index => $package)
                        <tr>
                            <td class="fw-semibold">{{ $index + 1 }}</td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge-plan {{ strtolower($package->name) }}">
                                        {{ $package->name }}
                                    </span>
                                </div>
                            </td>
                            <td class="price-cell">{{ $package->price }}</td>
                            <td class="description-cell">{{ $package->description ?? 'No description' }}</td>
                            <td>
                                <small class="text-muted font-monospace" style="font-size: 11px;" title="{{ $package->stripe_plan_id }}">
                                    {{ Str::limit($package->stripe_plan_id, 20, '...') }}
                                </small>
                            </td>
                            <td class="text-end actions-gap">
                                <a href="{{ route('package.edit', $package->id) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="fa-regular fa-pen-to-square"></i> Edit
                                </a>
                                <form action="{{ route('package.destroy', $package->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('Are you sure you want to delete this package? This will also delete it from Stripe.');">
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
        const table = $('#packagesTable').DataTable({
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
                searchPlaceholder: 'Search packages...',
                paginate: { previous: '<', next: '>' }
            }
        });

        $('#packageSearch').on('keyup change', function () {
            table.search(this.value).draw();
        });

        // Auto-apply badge classes based on package name
        $('.badge-plan').each(function() {
            const planName = $(this).text().toLowerCase();
            if (planName.includes('basic')) {
                $(this).addClass('basic');
            } else if (planName.includes('premium')) {
                $(this).addClass('premium');
            } else if (planName.includes('purchase')) {
                $(this).addClass('purchase');
            } else if (planName.includes('community')) {
                $(this).addClass('community');
            } else {
                $(this).addClass('basic'); // default
            }
        });
    });
</script>
@endsection