@extends('admin.layouts.master')
@section('title', 'Create Profile')

@section('content')
    <div class="container-fluid py-4">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                    <div>
                        <h4 class="mb-1">Create Profile</h4>
                        <small class="text-muted">Spin up a new profile for this account.</small>
                    </div>
                    <a href="{{ route('admin.profiles.index') }}" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left"></i> Back to Profiles
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

                @include('admin.profiles._form', [
                    'profile' => $profile,
                    'formAction' => route('admin.profiles.store'),
                    'formMethod' => 'POST',
                    'submitLabel' => 'Create Profile',
                ])
            </div>
        </div>
    </div>
@endsection
