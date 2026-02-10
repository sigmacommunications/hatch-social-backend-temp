@extends('admin.layouts.master')
@section('title', 'Edit Profile')

@section('content')
    <div class="container-fluid py-4">
        <div class="page-heading mb-3 d-flex justify-content-between">
            <div>
                <h2>Edit Profile</h2>
            </div>
            <a href="{{ route('users.profile.index', $userid) }}" class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>
        </div>

        <div class="card p-4">
            <form action="{{ route('users.profile.update', $profile->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')
                <input type="hidden" name="user_id" value="{{ $userid }}">

                <div class="mb-3">
                    <label>Name</label>
                    <input type="text" name="name" class="form-control" value="{{ old('name', $profile->name) }}"
                        required>
                </div>

                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" value="{{ old('email', $profile->email) }}"
                        required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control">{{ old('description', $profile->description) }}</textarea>
                </div>

                <div class="mb-3">
                    <label>Type</label>
                    <select name="type" class="form-control" required>
                        <option value="Content Creator"
                            {{ old('type', $profile->type) == 'Content Creator' ? 'selected' : '' }}>Content Creator
                        </option>
                        <option value="Learning & Exploring"
                            {{ old('type', $profile->type) == 'Learning & Exploring' ? 'selected' : '' }}>Learning &
                            Exploring</option>
                        <option value="Business & Enterpreneurship"
                            {{ old('type', $profile->type) == 'Business & Enterpreneurship' ? 'selected' : '' }}>Business &
                            Enterpreneurship</option>
                        <option value="Community & Connection"
                            {{ old('type', $profile->type) == 'Community & Connection' ? 'selected' : '' }}>Community &
                            Connection</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Privacy</label>
                    <select name="privacy" class="form-control" required>
                        <option value="public" {{ old('privacy', $profile->privacy) == 'public' ? 'selected' : '' }}>Public
                        </option>
                        <option value="private" {{ old('privacy', $profile->privacy) == 'private' ? 'selected' : '' }}>
                            Private</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Photo</label>
                    <input type="file" name="photo" class="form-control">
                    @if ($profile->photo)
                        <img src="{{ asset($profile->photo) }}" alt="Profile Photo" class="mt-2" width="100">
                    @endif
                </div>

                <button class="btn btn-primary">Update Profile</button>
            </form>
        </div>
    </div>
@endsection
