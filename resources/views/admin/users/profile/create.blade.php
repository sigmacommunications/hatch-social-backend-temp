@extends('admin.layouts.master')
@section('title', 'Create Profile')

@section('content')
    <div class="container-fluid py-4">
        <div class="page-heading mb-3 d-flex justify-content-between">
            <div>
                <h2>Create Profile</h2>
            </div>
            <a href="{{ route('users.profile.index', $userid) }}" class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>
        </div>

        <div class="card p-4">
            <form action="{{ route('users.profile.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="user_id" value="{{ $userid }}">

                <div class="mb-3">
                    <label>Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label>Type</label>
                    <select name="type" class="form-control" required>
                        <option value="Content Creator">Content Creator</option>
                        <option value="Learning & Exploring">Learning & Exploring</option>
                        <option value="Business & Enterpreneurship">Business & Enterpreneurship</option>
                        <option value="Community & Connection">Community & Connection</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Privacy</label>
                    <select name="privacy" id="privacy" class="form-control" required>
                        <option value="public">Public</option>
                        <option value="private">Private</option>
                    </select>
                </div>

                <!-- 4-digit passcode, hidden by default -->
                <div class="mb-3" id="passcodeDiv" style="display: none;">
                    <label>Passcode (4 digits)</label>
                    <input type="text" name="passcode" id="passcode" class="form-control" maxlength="4"
                        pattern="[A-Za-z0-9]{4}" placeholder="Enter 4-character passcode">
                </div>

                <div class="mb-3">
                    <label>Photo</label>
                    <input type="file" name="photo" class="form-control">
                </div>

                <button class="btn btn-primary">Save Profile</button>
            </form>
        </div>
    </div>

@section('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const privacySelect = document.getElementById('privacy');
            const passcodeDiv = document.getElementById('passcodeDiv');

            function togglePasscode() {
                if (privacySelect.value === 'private') {
                    passcodeDiv.style.display = 'block';
                    document.getElementById('passcode').required = true;
                } else {
                    passcodeDiv.style.display = 'none';
                    document.getElementById('passcode').required = false;
                    document.getElementById('passcode').value = '';
                }
            }

            privacySelect.addEventListener('change', togglePasscode);

            // Call once on page load
            togglePasscode();
        });
    </script>
@endsection

@endsection
