@extends('admin.layouts.master')
@section('title', 'Create User')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h4 class="mb-1">Create User</h4>
                    <small class="text-muted">Add a new account to the platform.</small>
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

            <form action="{{ route('users.store') }}" method="POST" class="row g-3">
                @csrf
                <div class="col-md-6">
                    <label class="form-label">First Name</label>
                    <input type="text" name="first_name" class="form-control" placeholder="Jane" value="{{ old('first_name') }}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Last Name</label>
                    <input type="text" name="last_name" class="form-control" placeholder="Doe" value="{{ old('last_name') }}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" placeholder="jane@example.com" value="{{ old('email') }}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select" required>
                        <option value="">Select role</option>
                        <option value="user" {{ old('role') === 'user' ? 'selected' : '' }}>User</option>
                        <option value="admin" {{ old('role') === 'admin' ? 'selected' : '' }}>Admin</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select" required>
                        <option value="active" {{ old('status') === 'active' ? 'selected' : '' }}>Active</option>
                        <option value="inactive" {{ old('status') === 'inactive' ? 'selected' : '' }}>Inactive</option>
                    </select>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Save User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
