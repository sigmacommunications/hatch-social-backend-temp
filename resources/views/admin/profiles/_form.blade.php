@php
    $method = strtoupper($formMethod ?? 'POST');
    $submitLabel = $submitLabel ?? 'Save Profile';
    $privacyValue = old('privacy', $profile->privacy ?? 'private');
@endphp

<form action="{{ $formAction }}" method="POST" enctype="multipart/form-data" class="row g-3">
    @csrf
    @if (!in_array($method, ['GET', 'POST']))
        @method($method)
    @endif

    <div class="col-md-6">
        <label class="form-label fw-semibold">Name</label>
        <input type="text" name="name" class="form-control" value="{{ old('name', $profile->name ?? '') }}"
            required>
    </div>

    <div class="col-md-6">
        <label class="form-label fw-semibold">Email</label>
        <input type="email" name="email" class="form-control"
            value="{{ old('email', $profile->email ?? '') }}" placeholder="name@email.com">
    </div>

    <div class="col-md-6">
        <label class="form-label fw-semibold">Privacy</label>
        <select name="privacy" class="form-select">
            <option value="public" {{ $privacyValue === 'public' ? 'selected' : '' }}>Public</option>
            <option value="private" {{ $privacyValue === 'private' ? 'selected' : '' }}>Private</option>
            @if (!in_array($privacyValue, ['public', 'private']))
                <option value="{{ $privacyValue }}" selected>{{ ucfirst($privacyValue) }}</option>
            @endif
        </select>
    </div>

    <div class="col-md-6">
        <label class="form-label fw-semibold">Address</label>
        <input type="text" name="address" class="form-control" value="{{ old('address', $profile->address ?? '') }}"
            placeholder="City, Country">
    </div>

    <div class="col-12">
        <label class="form-label fw-semibold">Description</label>
        <textarea name="description" rows="3" class="form-control" placeholder="Tell people what this profile is about">{{ old('description', $profile->description ?? '') }}</textarea>
    </div>

    <div class="col-md-6">
        <label class="form-label fw-semibold">Profile Photo</label>
        <input type="file" name="photo" class="form-control" accept="image/*">
        @if (!empty($profile->photo))
            <div class="mt-2">
                <img src="{{ asset($profile->photo) }}" alt="Profile photo" style="height:70px; border-radius:8px;">
            </div>
        @endif
    </div>

    <div class="col-12">
        <button type="submit" class="btn btn-primary">
            <i class="fa-solid fa-floppy-disk me-1"></i> {{ $submitLabel }}
        </button>
    </div>
</form>
