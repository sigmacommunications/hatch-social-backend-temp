@extends('admin.layouts.master')
@section('title', isset($package) ? 'Edit Package' : 'Create Package')

@section('styles')
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
    .form-card {
        background: #fff;
        border-radius: 14px;
        border: 1px solid #eef1f7;
        box-shadow: 0 12px 32px rgba(0, 0, 0, 0.04);
        overflow: hidden;
    }
    .form-header {
        padding: 20px 24px;
        border-bottom: 1px solid #f1f5f9;
        background: #f8fafc;
    }
    .form-header h5 {
        font-weight: 700;
        color: #0f172a;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .form-header h5 i {
        color: #4f46e5;
    }
    .form-body {
        padding: 24px;
    }
    .form-label {
        font-weight: 600;
        color: #374151;
        margin-bottom: 8px;
        display: block;
    }
    .form-control-custom {
        border: 1px solid #d1d5db;
        border-radius: 10px;
        padding: 12px 16px;
        font-size: 15px;
        transition: all 0.2s ease;
        width: 100%;
    }
    .form-control-custom:focus {
        border-color: #4f46e5;
        box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        outline: none;
    }
    .form-control-custom::placeholder {
        color: #9ca3af;
    }
    .form-group {
        margin-bottom: 24px;
    }
    .form-text {
        font-size: 13px;
        color: #6b7280;
        margin-top: 6px;
    }
    .btn-submit {
        background: linear-gradient(135deg, #4f46e5, #6366f1);
        color: white;
        border: none;
        border-radius: 10px;
        padding: 12px 28px;
        font-weight: 600;
        font-size: 15px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.2s ease;
        cursor: pointer;
    }
    .btn-submit:hover {
        background: linear-gradient(135deg, #4338ca, #4f46e5);
        transform: translateY(-1px);
        box-shadow: 0 8px 20px rgba(79, 70, 229, 0.25);
    }
    .btn-cancel {
        background: #f3f4f6;
        color: #374151;
        border: 1px solid #d1d5db;
        border-radius: 10px;
        padding: 12px 24px;
        font-weight: 600;
        font-size: 15px;
        margin-left: 12px;
        transition: all 0.2s ease;
    }
    .btn-cancel:hover {
        background: #e5e7eb;
        color: #111827;
    }
    .form-actions {
        display: flex;
        align-items: center;
        gap: 12px;
        padding-top: 24px;
        border-top: 1px solid #f1f5f9;
        margin-top: 32px;
    }
    .input-with-icon {
        position: relative;
    }
    .input-icon {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: #9ca3af;
        font-size: 16px;
    }
    .input-with-icon input {
        padding-left: 44px;
    }
    .price-wrapper {
        position: relative;
        display: inline-block;
        width: 100%;
    }
    .price-wrapper::before {
        content: '$';
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: #6b7280;
        font-weight: 600;
        z-index: 2;
    }
    .price-wrapper input {
        padding-left: 32px;
    }
    .error-message {
        color: #dc2626;
        font-size: 14px;
        margin-top: 6px;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    .error-message i {
        font-size: 14px;
    }
    .form-control-custom.is-invalid {
        border-color: #dc2626;
        background-color: #fef2f2;
    }
    .form-control-custom.is-invalid:focus {
        box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
    }
    @media (max-width: 768px) {
        .form-body {
            padding: 20px;
        }
        .form-actions {
            flex-direction: column;
            gap: 10px;
        }
        .btn-cancel {
            margin-left: 0;
            width: 100%;
        }
        .btn-submit {
            width: 100%;
        }
    }
</style>
@endsection

@section('content')
<div class="container-fluid py-4">
    <div class="page-heading">
        <div>
            <h2>{{ isset($package) ? 'Edit Package' : 'Create New Package' }}</h2>
            <p>{{ isset($package) ? 'Update package details' : 'Add a new subscription package to your platform' }}</p>
        </div>
        <div>
            <a href="{{ route('package.index') }}" class="btn btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Packages
            </a>
        </div>
    </div>

    <div class="form-card">
        <div class="form-header">
            <h5>
                <i class="fa-solid {{ isset($package) ? 'fa-edit' : 'fa-plus-circle' }}"></i>
                {{ isset($package) ? 'Edit Package Details' : 'Create New Package' }}
            </h5>
        </div>
        
        <div class="form-body">
            <form action="{{ isset($package) ? route('package.update', $package->id) : route('package.store') }}" method="POST" id="packageForm">
                @csrf
                @if (isset($package))
                    @method('PUT')
                @endif

                <div class="form-group">
                    <label for="name" class="form-label">Package Name</label>
                    <div class="input-with-icon">
                        <i class="input-icon fa-solid fa-tag"></i>
                        <input type="text" 
                               name="name" 
                               id="name" 
                               class="form-control-custom @error('name') is-invalid @enderror" 
                               value="{{ old('name', $package->name ?? '') }}" 
                               placeholder="Enter package name (e.g., Premium, Basic)">
                    </div>
                    @error('name')
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            {{ $message }}
                        </div>
                    @enderror
                    <div class="form-text">Choose a descriptive name for your package</div>
                </div>

                <div class="form-group">
                    <label for="price" class="form-label">Monthly Price</label>
                    <div class="price-wrapper">
                        <input type="number" 
                               name="price" 
                               id="price" 
                               class="form-control-custom @error('price') is-invalid @enderror" 
                               value="{{ old('price', $package->price ?? '') }}" 
                               placeholder="0.00"
                               step="0.01"
                               min="0">
                    </div>
                    @error('price')
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            {{ $message }}
                        </div>
                    @enderror
                    <div class="form-text">Enter the monthly subscription price in USD</div>
                </div>

                <div class="form-group">
                    <label for="description" class="form-label">Description</label>
                    <textarea name="description" 
                              id="description" 
                              class="form-control-custom @error('description') is-invalid @enderror" 
                              rows="4"
                              placeholder="Describe the features and benefits of this package...">{{ old('description', $package->description ?? '') }}</textarea>
                    @error('description')
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            {{ $message }}
                        </div>
                    @enderror
                    <div class="form-text">Optional: Add details about what this package includes</div>
                </div>

                @if(isset($package) && $package->stripe_plan_id)
                <div class="form-group">
                    <label class="form-label">Stripe Plan ID</label>
                    <div class="input-with-icon">
                        <i class="input-icon fa-brands fa-stripe"></i>
                        <input type="text" 
                               class="form-control-custom" 
                               value="{{ $package->stripe_plan_id }}" 
                               readonly
                               style="background-color: #f9fafb;">
                    </div>
                    <div class="form-text">This ID is automatically generated by Stripe</div>
                </div>
                @endif

                <div class="form-actions">
                    <button type="submit" class="btn-submit">
                        <i class="fa-solid {{ isset($package) ? 'fa-save' : 'fa-plus-circle' }}"></i>
                        {{ isset($package) ? 'Update Package' : 'Create Package' }}
                    </button>
                    <a href="{{ route('package.index') }}" class="btn-cancel">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('packageForm');
        const priceInput = document.getElementById('price');
        
        // Format price input on blur
        priceInput.addEventListener('blur', function() {
            let value = parseFloat(this.value);
            if (!isNaN(value) && value >= 0) {
                this.value = value.toFixed(2);
            }
        });
        
        // Validate form before submission
        form.addEventListener('submit', function(e) {
            let isValid = true;
            const nameInput = document.getElementById('name');
            const priceInput = document.getElementById('price');
            
            // Reset previous error states
            [nameInput, priceInput].forEach(input => {
                input.classList.remove('is-invalid');
            });
            
            // Validate name
            if (!nameInput.value.trim()) {
                nameInput.classList.add('is-invalid');
                isValid = false;
            }
            
            // Validate price
            const priceValue = parseFloat(priceInput.value);
            if (isNaN(priceValue) || priceValue < 0) {
                priceInput.classList.add('is-invalid');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
                // Scroll to first error
                const firstError = document.querySelector('.is-invalid');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    });
</script>
@endsection