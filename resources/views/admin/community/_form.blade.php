@php
    $method = strtoupper($method ?? 'POST');
    $action = $action ?? '#';
@endphp

<form action="{{ $action }}" method="POST" enctype="multipart/form-data" class="row g-3">
    @csrf
    @if (!in_array($method, ['GET', 'POST']))
        @method($method)
    @endif

    <div class="col-md-6">
        <label class="form-label">Title</label>
        <input type="text" name="title" class="form-control" value="{{ old('title', $community->title ?? '') }}" required>
    </div>

    <div class="col-md-6">
        <label class="form-label">Privacy</label>
        <input type="text" name="privacy" class="form-control" value="{{ old('privacy', $community->privacy ?? 'public') }}">
    </div>

    <div class="col-12">
        <label class="form-label">Description</label>
        <textarea name="description" class="form-control" rows="3">{{ old('description', $community->description ?? '') }}</textarea>
    </div>

    <div class="col-md-4">
        <label class="form-label">Membership Cost</label>
        <select name="membership_cost" class="form-select">
            @php $membership = old('membership_cost', $community->membership_cost ?? 'no'); @endphp
            <option value="yes" {{ $membership === 'yes' ? 'selected' : '' }}>Yes</option>
            <option value="no" {{ $membership === 'no' ? 'selected' : '' }}>No</option>
            @if (!in_array($membership, ['yes', 'no']))
                <option value="{{ $membership }}" selected>{{ ucfirst($membership) }}</option>
            @endif
        </select>
    </div>

    <div class="col-md-4">
        <label class="form-label">Joining Cost</label>
        <input type="number" name="joining_cost" step="0.01" min="0" class="form-control"
            value="{{ old('joining_cost', $community->joining_cost) }}">
    </div>

    <div class="col-md-4">
        <label class="form-label">App Service Cost</label>
        <input type="number" name="app_service_charges" step="0.01" min="0" class="form-control"
            value="{{ old('app_service_charges', $community->app_service_charges) }}">
    </div>

    <div class="col-md-4">
        <label class="form-label">Status</label>
        <input type="text" name="status" class="form-control" value="{{ old('status', $community->status ?? 'active') }}">
    </div>

    <div class="col-md-4">
        <label class="form-label">Profile (optional)</label>
        <input type="number" name="profile_id" class="form-control" value="{{ old('profile_id', $profileId ?? $community->profile_id) }}">
    </div>

    <div class="col-md-4">
        <label class="form-label">Image</label>
        <input type="file" name="image" class="form-control" accept="image/*">
        @if (!empty($community->image))
            <div class="mt-2">
                <img src="{{ asset($community->image) }}" alt="Community" style="height:60px; border-radius:6px;">
            </div>
        @endif
    </div>

    <div class="col-12">
        <button class="btn btn-primary">
            <i class="fa-solid fa-floppy-disk me-1"></i> {{ $submitLabel ?? 'Save' }}
        </button>
    </div>
</form>
