@extends('admin.layouts.master')
@section('title', 'Create Community')

@section('content')
    <div class="container-fluid py-3">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                    <div>
                        <h4 class="mb-1">Create Community</h4>
                        <small class="text-muted">Set up a new community/nest.</small>
                    </div>
                    <a href="{{ route('nests.index') }}" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left"></i> Back
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

                @include('admin.community._form', [
                    'community' => $community,
                    'profileId' => $profileId ?? null,
                    'action' => route('nests.store', ['profile_id' => $profileId]),
                    'method' => 'POST',
                    'submitLabel' => 'Create Community',
                ])
            </div>
        </div>
    </div>
@endsection
