@extends('admin.layouts.master')

@section('content')
    <style>
        .wallet-container {
            padding: 20px;
            max-width: 1200px;
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

        .wallet-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .wallet-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }

        .wallet-header p {
            color: #666;
            font-size: 1.1rem;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
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

        .stat-card.available {
            border-left-color: #00bfa5;
        }

        .stat-card.withdrawn {
            border-left-color: #2196F3;
        }

        .stat-card.pending {
            border-left-color: #FF9800;
        }

        .stat-card h3 {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .stat-card .amount {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
        }

        .withdraw-section {
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

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #00bfa5;
        }

        .form-text {
            font-size: 0.875rem;
            color: #666;
            margin-top: 5px;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #00bfa5;
            color: white;
        }

        .btn-primary:hover:not(:disabled) {
            background: #009688;
            transform: translateY(-2px);
        }

        .btn-primary:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        .btn-outline {
            background: transparent;
            border: 2px solid #00bfa5;
            color: #00bfa5;
        }

        .btn-outline:hover {
            background: #00bfa5;
            color: white;
        }

        .status-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .badge-success {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .badge-warning {
            background: #fff3e0;
            color: #ef6c00;
        }

        .badge-danger {
            background: #ffebee;
            color: #c62828;
        }

        .history-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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

        .alert-warning {
            background: #fff3e0;
            border: 1px solid #ffb74d;
            color: #ef6c00;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .text-success {
            color: #00bfa5;
        }

        .text-danger {
            color: #f44336;
        }

        .text-muted {
            color: #666;
        }

        .monospace {
            font-family: 'Courier New', monospace;
        }

        .available-balance-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .available-balance {
            font-size: 3rem;
            font-weight: 700;
            color: #00bfa5;
            margin: 10px 0;
        }

        .balance-label {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 20px;
        }
    </style>

    <div class="wallet-container">

    <!-- Success/Error Messages -->
    @if (session('success'))
        <div class="alert alert-success">
            <span>✅</span>
            <div>
                <strong>Success!</strong> {{ session('success') }}
            </div>
        </div>
    @endif

    @if (session('error'))
        <div class="alert alert-danger">
            <span>❌</span>
            <div>
                <strong>Error!</strong> {{ session('error') }}
            </div>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-danger">
            <span>⚠️</span>
            <div>
                <strong>Please fix the following errors:</strong>
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        </div>
    @endif

    <!-- Header -->
    <div class="wallet-header">
        <h1>💰 Wallet & Withdraw</h1>
        <p>Manage your earnings and withdraw funds to your bank account</p>
    </div>

    @php
        $available = $wallet->available_amount ?? 0;
        $minWithdraw = 50;
    @endphp

    <!-- Stats Cards -->
    <div class="stats-cards">
		<div class="stat-card available">
			<h3>Available Balance</h3>
			<div class="amount">${{ number_format($wallet->available_amount ?? 0, 2) }}</div>
			<p class="text-muted">Ready to withdraw</p>
		</div>

		<div class="stat-card pending">
			<h3>Pending Balance</h3>
			<div class="amount">${{ number_format($wallet->pending_amount ?? 0, 2) }}</div>
			<p class="text-muted">In 14-day refundable period</p>
		</div>

		<div class="stat-card withdrawn">
			<h3>Total Withdrawn</h3>
			<div class="amount">${{ number_format($totalWithdrawn, 2) }}</div>
			<p class="text-muted">All time withdrawals</p>
		</div>
	</div>

    <!-- Withdraw Section -->
    <div class="withdraw-section">
       

        @if (optional($profile)->stripe_connect_id)
            <form action="{{ route('wallet.withdraw', $profile->id) }}" method="POST" id="withdrawForm">
                @csrf

                <div class="form-group">
                    <label for="amount" class="form-label">Amount to Withdraw ($)</label>
                    <input type="number" step="0.01" min="{{ $minWithdraw }}" class="form-control" id="amount"
                        name="amount" required placeholder="Enter amount"
                        value="{{ old('amount', $minWithdraw) }}"
                        max="{{ $available }}">
                    <div class="form-text">
                        Available: ${{ number_format($available, 2) }} | Minimum: ${{ number_format($minWithdraw, 2) }}
                    </div>
                    @error('amount')
                        <div class="text-danger" style="margin-top: 5px; font-size: 14px;">{{ $message }}</div>
                    @enderror
                </div>

                <button type="submit" class="btn btn-primary" id="withdrawBtn"
                    {{ !$wallet || $available < $minWithdraw ? 'disabled' : '' }}>
                    💳 Withdraw to Bank Account
                </button>
            </form>
        @else
            <div class="alert alert-warning">
                <h4>⚠️ Stripe Account Not Connected!</h4>
                <p>You need to connect your Stripe account to withdraw funds. Click the button below to set up payouts.</p>
                {{-- <a href="{{ route('stripe.connect') }}" class="btn btn-outline">
                    🚀 Setup Payouts Now
                </a> --}}
            </div>
        @endif
    </div>

    <!-- Withdrawal History -->
    <div class="history-section">
        <h2 class="section-title">Withdrawal History</h2>

        @if ($withdrawals->count() > 0)
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Transfer ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($withdrawals as $withdrawal)
                            <tr>
                                <td>{{ $withdrawal->created_at->format('M d, Y h:i A') }}</td>
                                <td><strong>${{ number_format($withdrawal->amount, 2) }}</strong></td>
                                <td>
                                    <span
                                        class="status-badge
                                    @if ($withdrawal->status == 'completed') badge-success
                                    @elseif($withdrawal->status == 'pending') badge-warning
                                    @else badge-danger @endif">
                                        {{ ucfirst($withdrawal->status) }}
                                    </span>
                                </td>
                                <td>
                                    <small class="monospace text-muted">{{ $withdrawal->stripe_transfer_id }}</small>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>

            @if ($withdrawals->hasPages())
                <div style="margin-top: 20px; display: flex; justify-content: center;">
                    {{ $withdrawals->links() }}
                </div>
            @endif
        @else
            <div style="text-align: center; padding: 40px;">
                <div style="font-size: 48px; margin-bottom: 10px;">📋</div>
                <h4 style="color: #666; margin-bottom: 10px;">No Withdrawal History</h4>
                <p style="color: #666;">You haven't made any withdrawals yet.</p>
            </div>
        @endif
    </div>
</div>

<script>
    const amountInput = document.getElementById('amount');
    const withdrawBtn = document.getElementById('withdrawBtn');
    const available = {{ $available }};
    const minWithdraw = {{ $minWithdraw }};

    amountInput?.addEventListener('input', function() {
        let value = parseFloat(this.value) || minWithdraw;

        if (value < minWithdraw) value = minWithdraw;
        if (value > available) value = available;

        this.value = value;

        if (withdrawBtn) {
            withdrawBtn.disabled = value < minWithdraw || value > available;
        }
    });

    document.getElementById('withdrawForm')?.addEventListener('submit', function() {
        if (withdrawBtn) {
            withdrawBtn.disabled = true;
            withdrawBtn.innerHTML = '⏳ Processing...';
        }
    });

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
