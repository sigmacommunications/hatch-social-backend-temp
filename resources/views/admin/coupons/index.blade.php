@extends('admin.layouts.master')

@section('content')
<style>
    .coupons-container {
        padding: 20px;
        max-width: 1400px;
        margin: 0 auto;
    }

    .alert {
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
    }

    .alert-success {
        background: #e8f5e8;
        border: 1px solid #4caf50;
        color: #2e7d32;
    }

    .alert-danger {
        background: #ffebee;
        border: 1px solid #f44336;
        color: #c62828;
    }

    .alert ul {
        margin: 10px 0 0 0;
        padding-left: 20px;
    }

    .coupons-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .coupons-header h1 {
        font-size: 2.5rem;
        font-weight: 700;
        color: #333;
        margin-bottom: 10px;
    }

    .coupons-header p {
        color: #666;
        font-size: 1.1rem;
    }

    .action-buttons {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .btn {
        padding: 12px 30px;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-primary {
        background: #00bfa5;
        color: white;
    }

    .btn-primary:hover {
        background: #009688;
        transform: translateY(-2px);
    }

    .btn-success {
        background: #4caf50;
        color: white;
    }

    .btn-success:hover {
        background: #45a049;
        transform: translateY(-2px);
    }

    .btn-info {
        background: #2196F3;
        color: white;
    }

    .btn-info:hover {
        background: #1976D2;
        transform: translateY(-2px);
    }

    .btn-danger {
        background: #f44336;
        color: white;
    }

    .btn-danger:hover {
        background: #d32f2f;
        transform: translateY(-2px);
    }

    .coupons-section {
        background: white;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }

    .section-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #333;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #f0f0f0;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
    }

    .table th,
    .table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #f0f0f0;
    }

    .table th {
        font-weight: 600;
        color: #666;
        background: #fafafa;
    }

    .table tbody tr:hover {
        background: #f8f9fa;
    }

    .badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.875rem;
        font-weight: 600;
    }

    .badge-success {
        background: #e8f5e8;
        color: #2e7d32;
    }

    .badge-danger {
        background: #ffebee;
        color: #c62828;
    }

    .badge-info {
        background: #e3f2fd;
        color: #1565c0;
    }

    .badge-warning {
        background: #fff3e0;
        color: #ef6c00;
    }

    .status-active {
        color: #00bfa5;
        font-weight: 600;
    }

    .status-inactive {
        color: #f44336;
        font-weight: 600;
    }

    .text-muted {
        color: #666;
    }

    .monospace {
        font-family: 'Courier New', monospace;
        background: #f5f5f5;
        padding: 2px 6px;
        border-radius: 4px;
        font-size: 0.875rem;
    }

    .action-buttons-small {
        display: flex;
        gap: 8px;
    }

    .btn-sm {
        padding: 8px 16px;
        font-size: 0.875rem;
    }

    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .empty-state {
        text-align: center;
        padding: 40px;
    }

    .empty-state-icon {
        font-size: 48px;
        margin-bottom: 10px;
    }

    .coupon-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border-left: 4px solid;
        transition: transform 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .stat-card.total {
        border-left-color: #2196F3;
    }

    .stat-card.active {
        border-left-color: #00bfa5;
    }

    .stat-card.percentage {
        border-left-color: #FF9800;
    }

    .stat-card.fixed {
        border-left-color: #9C27B0;
    }

    .stat-card h3 {
        font-size: 0.9rem;
        color: #666;
        margin-bottom: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .stat-card .count {
        font-size: 2rem;
        font-weight: 700;
        color: #333;
    }
	
	@media (max-width:767px){
		.coupons-container {
			max-width: 100%;
		}
		
		.coupons-header h1 {
			font-size: 20px;
				}

				.coupons-header p {
			font-size: 14px;
		}

				.coupon-stats {
			grid-template-columns: repeat(auto-fit, minmax(125px, 1fr));
			gap: 15px;
			}
		.stat-card h3 {
    font-size: 12px;
		}
		
		.stat-card .count {
    font-size: 22px;
		}
		
		.text-muted {
    font-size: 12px;
		}
		
		.action-buttons a {
    font-size: 12px;
    padding: 10px;
}
		
		.coupons-section {
    padding: 10px;
		}
		
		.section-title {
    font-size: 18px;
		}
		
		.table th, .table td {
    font-size: 12px;
		}
		
		.btn-sm {
    padding: 8px 16px;
    font-size: 10px !important;
		}
	}
</style>

<div class="coupons-container">
    <!-- Success/Error Messages -->
    @if(session('success'))
        <div class="alert alert-success">
            <span style="font-size: 20px; margin-right: 10px;">✅</span>
            <div>
                <strong>Success!</strong> {{ session('success') }}
            </div>
        </div>
    @endif

    @if(session('error'))
        <div class="alert alert-danger">
            <span style="font-size: 20px; margin-right: 10px;">❌</span>
            <div>
                <strong>Error!</strong> {{ session('error') }}
            </div>
        </div>
    @endif

    @if($errors->any())
        <div class="alert alert-danger">
            <span style="font-size: 20px; margin-right: 10px;">⚠️</span>
            <div>
                <strong>Please fix the following errors:</strong>
                <ul>
                    @foreach($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        </div>
    @endif

    <!-- Header -->
    <div class="coupons-header">
        <h1>🎫 Coupon Management</h1>
        <p>Create and manage discount coupons for your customers</p>
    </div>

    <!-- Stats Cards -->
    <div class="coupon-stats">
        <div class="stat-card total">
            <h3>Total Coupons</h3>
            <div class="count">{{ $totalCoupons }}</div>
            <p class="text-muted">All coupons</p>
        </div>

        <div class="stat-card active">
            <h3>Active Coupons</h3>
            <div class="count">{{ $activeCoupons }}</div>
            <p class="text-muted">Currently active</p>
        </div>

        <div class="stat-card percentage">
            <h3>Percentage Coupons</h3>
            <div class="count">{{ $percentageCoupons }}</div>
            <p class="text-muted">% Discount</p>
        </div>

        <div class="stat-card fixed">
            <h3>Fixed Amount</h3>
            <div class="count">{{ $fixedCoupons }}</div>
            <p class="text-muted">$ Discount</p>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="action-buttons">
        <a href="{{ route('admin.coupons.create',$profileid) }}" class="btn btn-primary">
            ➕ Create New Coupon
        </a>
    </div>

    <!-- Coupons List -->
    <div class="coupons-section">
        <h2 class="section-title">All Coupons</h2>
        
        @if($coupons->count() > 0)
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Code</th>
                            <th>Type</th>
                            <th>Value</th>
                            <th>Usage</th>
                            <th>Validity</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($coupons as $coupon)
                        <tr>
                            <td>
                                <strong>{{ $coupon->name }}</strong>
                                @if($coupon->valid_until && $coupon->valid_until->isPast())
                                    <br><small class="text-danger">Expired</small>
                                @endif
                            </td>
                            <td>
                                <code class="monospace">{{ $coupon->code }}</code>
                            </td>
                            <td>
                                <span class="badge badge-{{ $coupon->type === 'percentage' ? 'info' : 'warning' }}">
                                    {{ ucfirst($coupon->type) }}
                                </span>
                            </td>
                            <td>
                                <strong>
                                    {{ $coupon->type === 'percentage' ? $coupon->value.'%' : '$'.number_format($coupon->value, 2) }}
                                </strong>
                            </td>
                            <td>
                                {{ $coupon->times_redeemed }} / {{ $coupon->max_redemptions ?? '∞' }}
                            </td>
                            <td>
                                @if($coupon->valid_from && $coupon->valid_until)
                                    {{ $coupon->valid_from->format('M d, Y') }} - {{ $coupon->valid_until->format('M d, Y') }}
                                @else
                                    <span class="text-muted">Forever</span>
                                @endif
                            </td>
                            <td>
                                @if($coupon->is_active == 1)
                                    <span class="status-active">Active</span>
                                @else
                                    <span class="status-inactive">Inactive</span>
                                @endif
                            </td>
                            <td>
                                <div class="action-buttons-small">
                                    <form action="{{ route('admin.coupons.destroy', [$coupon,$profileid]) }}" method="POST" class="d-inline">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm" 
                                                onclick="return confirm('Are you sure you want to delete this coupon? This action cannot be undone.')">
                                            🗑️ Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            @if($coupons->hasPages())
            <div class="pagination">
                {{ $coupons->links() }}
            </div>
            @endif
        @else
            <div class="empty-state">
                <div class="empty-state-icon">🎫</div>
                <h4>No Coupons Found</h4>
                <p class="text-muted">You haven't created any coupons yet. Start by creating your first coupon!</p>
                <a href="{{ route('admin.coupons.create',$profileid) }}" class="btn btn-primary">
                    ➕ Create First Coupon
                </a>
            </div>
        @endif
    </div>
</div>

<script>
// Auto-hide messages after 5 seconds
document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s ease';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 5000);
    });
});
</script>
@endsection