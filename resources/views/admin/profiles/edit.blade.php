@extends('admin.layouts.master')
@section('title', $title ?? 'Edit Profile')

@section('content')
    <div class="container-fluid py-4">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                    <div>
                        <h4 class="mb-1">{{ $title ?? 'Edit Profile' }}</h4>
                        <small class="text-muted">Update this profile’s info and picture.</small>
                    </div>
                    <a href="{{ route('admin.profiles.index') }}" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left"></i> Back to Profiles
                    </a>
                </div>

                @if (session('success'))
                    <div class="alert alert-success">{{ session('success') }}</div>
                @endif
                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul class="mb-0">
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                @include('admin.profiles._form', [
                    'profile' => $profile,
                    'formAction' => $formAction ?? route('admin.profile.update'),
                    'formMethod' => $formMethod ?? 'PUT',
                    'submitLabel' => 'Save Changes',
                ])
            </div>
        </div>
    </div>
@endsection
