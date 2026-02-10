@extends('admin.layouts.master')
@section('title', 'Edit User')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h4 class="mb-1">Edit User</h4>
                    <small class="text-muted">Update name or status for this account.</small>
                </div>
                <a href="{{ route('users.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left"></i> Back to Users
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-danger">
                    <ul class="mb-0">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('users.update', $user->id) }}" method="POST" class="row g-3">
                @csrf
                @method('PUT')

                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="text" class="form-control" value="{{ $user->email }}" readonly>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Current Plan</label>
                    <input type="text" class="form-control" value="{{ $user->current_plan ?? '—' }}" readonly>
                </div>

                <div class="col-md-6">
                    <label class="form-label">First Name</label>
                    <input type="text" class="form-control" name="first_name" value="{{ old('first_name', $user->first_name) }}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Last Name</label>
                    <input type="text" class="form-control" name="last_name" value="{{ old('last_name', $user->last_name) }}" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Status</label>
                    <select class="form-select" name="status" required>
                        <option value="active" {{ old('status', $user->status) === 'active' ? 'selected' : '' }}>Active</option>
                        <option value="inactive" {{ old('status', $user->status) === 'inactive' ? 'selected' : '' }}>Inactive</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Role</label>
                    <input type="text" class="form-control" value="{{ $user->role ?? 'user' }}" readonly>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
