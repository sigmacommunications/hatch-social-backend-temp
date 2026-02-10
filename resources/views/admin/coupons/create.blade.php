@extends('admin.layouts.master')

@section('content')
<style>
    .compact-form-container {
        padding: 15px;
        max-width: 600px;
        margin: 0;
    }

    .alert {
        padding: 10px 12px;
        border-radius: 6px;
        margin-bottom: 12px;
        display: flex;
        align-items: center;
        font-size: 0.8rem;
    }

    .alert-danger {
        background: #ffebee;
        border: 1px solid #f44336;
        color: #c62828;
    }

    .alert ul {
        margin: 5px 0 0 0;
        padding-left: 15px;
        font-size: 0.75rem;
    }

    .form-header {
        margin-bottom: 15px;
    }

    .form-header h1 {
        font-size: 1.3rem;
        font-weight: 700;
        color: #333;
        margin-bottom: 3px;
    }

    .form-header p {
        color: #666;
        font-size: 0.8rem;
        margin: 0;
    }

    .info-box {
        background: #e3f2fd;
        border: 1px solid #2196F3;
        border-radius: 6px;
        padding: 12px;
        margin-bottom: 15px;
    }

    .info-box h4 {
        color: #1565c0;
        margin-bottom: 6px;
        font-size: 0.85rem;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .info-box p {
        color: #1565c0;
        margin-bottom: 3px;
        font-size: 0.75rem;
        line-height: 1.2;
    }

    .form-section {
        background: white;
        border-radius: 8px;
        padding: 15px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        margin-bottom: 15px;
    }

    .form-group {
        margin-bottom: 12px;
    }

    .form-label {
        display: block;
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
        font-size: 0.8rem;
    }

    .required::after {
        content: " *";
        color: #f44336;
    }

    .form-control {
        width: 100%;
        padding: 6px 10px;
        border: 1px solid #d1d5db;
        border-radius: 4px;
        font-size: 0.8rem;
        transition: border-color 0.2s ease;
        background: white;
        height: 32px;
    }

    .form-control:focus {
        outline: none;
        border-color: #00bfa5;
        box-shadow: 0 0 0 2px rgba(0, 191, 165, 0.1);
    }

    .form-text {
        font-size: 0.7rem;
        color: #666;
        margin-top: 2px;
        display: block;
        line-height: 1.2;
    }

    .form-select {
        width: 100%;
        padding: 6px 10px;
        border: 1px solid #d1d5db;
        border-radius: 4px;
        font-size: 0.8rem;
        background: white;
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
        background-position: right 6px center;
        background-repeat: no-repeat;
        background-size: 10px;
        height: 32px;
    }

    /* Compact Grid Layout */
    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px;
    }

    .form-full-width {
        grid-column: 1 / -1;
    }

    .form-actions {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 8px;
        margin-top: 15px;
        padding-top: 12px;
        border-top: 1px solid #e5e7eb;
    }

    .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        font-size: 0.8rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 4px;
        justify-content: center;
        height: 32px;
    }

    .btn-primary {
        background: #00bfa5;
        color: white;
        border: 1px solid #00bfa5;
    }

    .btn-primary:hover {
        background: #009688;
        border-color: #009688;
    }

    .btn-outline {
        background: transparent;
        border: 1px solid #00bfa5;
        color: #00bfa5;
    }

    .btn-outline:hover {
        background: #00bfa5;
        color: white;
    }

    .text-danger {
        color: #f44336;
        font-size: 0.7rem;
        margin-top: 2px;
        display: block;
    }

    /* Compact datetime inputs */
    input[type="datetime-local"] {
        font-size: 0.8rem;
        height: 32px;
    }

    /* Loading state */
    .btn-loading {
        position: relative;
        color: transparent !important;
    }

    .btn-loading::after {
        content: "";
        position: absolute;
        width: 12px;
        height: 12px;
        top: 50%;
        left: 50%;
        margin-left: -6px;
        margin-top: -6px;
        border: 2px solid #ffffff;
        border-radius: 50%;
        border-right-color: transparent;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        to {
            transform: rotate(360deg);
        }
    }
	
	@media (max-width:767px) {
	.form-grid {
    display: block;
		}
		}
</style>

<div class="compact-form-container">
    <!-- Error Messages -->
    @if($errors->any())
        <div class="alert alert-danger">
            <span style="font-size: 14px; margin-right: 6px;">⚠️</span>
            <div>
                <strong>Please fix the errors:</strong>
                <ul>
                    @foreach($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        </div>
    @endif

    <!-- Header -->
    <div class="form-header">
        <h1>🎫 Create New Coupon</h1>
        <p>Create a discount coupon for your customers</p>
    </div>

    <!-- Info Box -->
    <div class="info-box">
        <h4>💡 Coupon Information</h4>
        <p><strong>Percentage Coupons:</strong> Apply percentage discount (e.g., 10% off)</p>
        <p><strong>Fixed Amount Coupons:</strong> Apply fixed amount discount (e.g., $20 off)</p>
        <p><strong>Stripe Integration:</strong> Coupons will be automatically synced with Stripe</p>
    </div>

    <!-- Form Section -->
    <div class="form-section">
        <form action="{{ route('admin.coupons.store',$profileid) }}" method="POST" id="couponForm">
            @csrf

            <div class="form-grid">
                <!-- Coupon Name - Full Width -->
                <div class="form-group form-full-width">
                    <label for="name" class="form-label required">Coupon Name</label>
                    <input type="text" class="form-control" id="name" name="name" 
                           value="{{ old('name') }}" required 
                           placeholder="Summer Sale, Welcome Discount">
                    <span class="form-text">A descriptive name for this coupon</span>
                    @error('name')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>

                <!-- Coupon Code - Full Width -->
                <div class="form-group form-full-width">
                    <label for="code" class="form-label required">Coupon Code</label>
                    <input type="text" class="form-control" id="code" name="code" 
                           value="{{ old('code') }}" required 
                           placeholder="SUMMER2024, WELCOME20">
                    <span class="form-text">Unique code for checkout</span>
                    @error('code')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>

                <!-- Discount Type & Value - Side by Side -->
                <div class="form-group">
                    <label for="type" class="form-label required">Discount Type</label>
                    <select class="form-select" id="type" name="type" required>
                        <option value="percentage" {{ old('type') == 'percentage' ? 'selected' : '' }}>Percentage</option>
                    </select>
                    @error('type')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="value" class="form-label required">Discount Value</label>
                    <input type="number" step="0.01" min="0" class="form-control" id="value" 
                           name="value" value="{{ old('value') }}" required 
                           placeholder="10">
                    <span class="form-text" id="valueHelp">Enter value</span>
                    @error('value')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>

                <!-- Maximum Redemptions - Full Width -->
                <div class="form-group form-full-width">
                    <label for="max_redemptions" class="form-label">Maximum Redemptions</label>
                    <input type="number" min="1" class="form-control" id="max_redemptions" 
                           name="max_redemptions" value="{{ old('max_redemptions') }}" 
                           placeholder="100">
                    <span class="form-text">Leave empty for unlimited usage</span>
                    @error('max_redemptions')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>

                <!-- Valid From & Until - Side by Side -->
                <div class="form-group">
                    <label for="valid_from" class="form-label">Valid From</label>
                    <input type="datetime-local" class="form-control" id="valid_from" 
                           name="valid_from" value="{{ old('valid_from') }}">
                    <span class="form-text">Start date</span>
                    @error('valid_from')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="valid_until" class="form-label">Valid Until</label>
                    <input type="datetime-local" class="form-control" id="valid_until" 
                           name="valid_until" value="{{ old('valid_until') }}">
                    <span class="form-text">End date</span>
                    @error('valid_until')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    🎫 Create
                </button>
                <a href="{{ route('admin.coupons.index',$profileid) }}" class="btn btn-outline">
                    ← Back
                </a>
            </div>
        </form>
    </div>
</div>

<script>
// Update help text based on discount type
document.getElementById('type').addEventListener('change', function() {
    updateValueHelp();
});

function updateValueHelp() {
    const valueHelp = document.getElementById('valueHelp');
    const valueInput = document.getElementById('value');
    const type = document.getElementById('type').value;
    
    if (type === 'percentage') {
        valueHelp.textContent = 'Percentage (1-100)';
        valueInput.placeholder = '10';
        valueInput.step = '1';
        valueInput.min = '1';
        valueInput.max = '100';
    } else if (type === 'fixed') {
        valueHelp.textContent = 'Amount ($)';
        valueInput.placeholder = '20';
        valueInput.step = '0.01';
        valueInput.min = '0.01';
        valueInput.max = '';
    } else {
        valueHelp.textContent = 'Enter value';
        valueInput.placeholder = '10';
    }
}

// Generate random coupon code when name is filled
document.getElementById('name').addEventListener('blur', function() {
    const codeInput = document.getElementById('code');
    if (!codeInput.value && this.value) {
        const baseCode = this.value
            .toUpperCase()
            .replace(/[^A-Z0-9]/g, '')
            .substring(0, 6);
            
        const randomSuffix = Math.random().toString(36).substring(2, 5).toUpperCase();
        codeInput.value = baseCode + randomSuffix;
    }
});

// Form validation and submission
document.getElementById('couponForm').addEventListener('submit', function(e) {
    const type = document.getElementById('type').value;
    const value = parseFloat(document.getElementById('value').value);
    const submitBtn = document.getElementById('submitBtn');
    
    // Basic validation
    if (!type) {
        e.preventDefault();
        alert('Please select a discount type');
        return false;
    }
    
    if (type === 'percentage' && (value < 1 || value > 100)) {
        e.preventDefault();
        alert('Percentage value must be between 1 and 100');
        return false;
    }
    
    if (type === 'fixed' && value < 0.01) {
        e.preventDefault();
        alert('Fixed amount must be at least $0.01');
        return false;
    }
    
    // Show loading state
    submitBtn.classList.add('btn-loading');
    submitBtn.disabled = true;
});

// Auto-hide messages
document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.3s ease';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 300);
        }, 5000);
    });
    
    // Initialize help text
    updateValueHelp();
    
    // Set minimum datetime for date inputs
    const now = new Date();
    const timezoneOffset = now.getTimezoneOffset() * 60000;
    const localISOTime = new Date(now - timezoneOffset).toISOString().slice(0, 16);
    
    const validFrom = document.getElementById('valid_from');
    const validUntil = document.getElementById('valid_until');
    
    if (validFrom) validFrom.min = localISOTime;
    if (validUntil) validUntil.min = localISOTime;
});
</script>
@endsection