@extends('admin.layouts.master')

@section('content')
    <style>
        :root {
            --card-w: 120px;
            --card-h: 120px;
            --gap: 22px;
            --accent: #00bfa5;
            --muted: #bdbdbd;
        }

        html,
        body {
            height: 100%;
            margin: 0;
            font-family: "Helvetica Neue", Arial, sans-serif;
            color: Black;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .wrap {
            min-height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 40px 20px;
            box-sizing: border-box;
            text-align: center;
        }

        h1.title {
            font-weight: 600;
            font-size: 40px;
            margin: 0 0 30px;
            letter-spacing: 0.4px;
        }

        .tiles {
            display: flex;
            gap: var(--gap);
            flex-wrap: wrap;
            justify-content: center;
            align-items: flex-end;
            margin-bottom: 28px;
        }

        .profile-tile {
            width: var(--card-w);
            cursor: pointer;
            user-select: none;
            transition: transform .18s ease, box-shadow .18s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-tile:focus,
        .profile-tile:hover {
            transform: translateY(-8px) scale(1.03);
            z-index: 2;
        }

        .avatar {
            width: var(--card-w);
            height: var(--card-h);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 6px 18px rgba(0, 0, 0, .6);
            border: 2px solid rgba(255, 255, 255, 0.04);
            overflow: hidden;
            position: relative;
        }

        .avatar .initial {
            font-size: 36px;
            font-weight: 700;
            color: #fff;
            letter-spacing: 1px;
        }

        .avatar.color-1 {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }

        .avatar.color-2 {
            background: linear-gradient(135deg, #00b09b, #96c93d);
        }

        .avatar.color-3 {
            background: linear-gradient(135deg, #ff5f6d, #ffc371);
        }

        .avatar.color-4 {
            background: linear-gradient(135deg, #00c6ff, #0072ff);
        }

        .avatar.color-5 {
            background: linear-gradient(135deg, #ff9a8b, #ffd6a5);
        }

        .profile-name {
            margin-top: 10px;
            font-size: 14px;
            color: var(--muted);
            width: 100%;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        .profile-actions {
            display: flex;
            gap: 6px;
            margin-top: 8px;
        }

        .profile-actions .btn {
            padding: 6px 10px;
            border-radius: 8px;
            font-size: 12px;
        }

        @media (max-width:720px) {
            :root {
                --card-w: 80px;
                --card-h: 80px;
                --gap: 14px;
            }

            h1.title {
                font-size: 20px;
                margin-bottom: 18px;
            }

            .profile-name h5 {
                font-size: 12px;
            }

            .wrap {
                min-height: 85%;
            }
        }

        @media (min-width:768px) and (max-width:1023px) {
            .title {
                font-size: 28px;
            }

            :root {
                --card-w: 80px;
                --card-h: 80px;
            }

            .profile-name h5 {
                font-size: 14px;
            }
        }
    </style>

    <div class="wrap">
        <div class="d-flex justify-content-between align-items-center flex-wrap" style="width:100%;max-width:960px;">
            <h1 class="title mb-3 mb-md-0">Profile Access?</h1>
            <div class="d-flex gap-2 flex-wrap">
                <a href="{{ route('admin.profiles.create') }}" class="btn btn-success">
                    <i class="fa-solid fa-circle-plus me-1"></i> Add Profile
                </a>
                <a href="{{ route('admin.profile.edit') }}" class="btn btn-primary">
                    <i class="fa-regular fa-pen-to-square me-1"></i> Edit My Profile
                </a>
            </div>
        </div>

        @if (session('success'))
            <div class="alert alert-success mt-3">{{ session('success') }}</div>
        @endif

        <div class="tiles" id="profilesRow">
            @forelse ($profiles as $profile)
                @php
                    $initials = collect(explode(' ', $profile->name ?? 'U'))
                        ->map(fn($n) => strtoupper(substr($n, 0, 1)))
                        ->take(2)
                        ->join('');
                    $colorClass = 'color-' . (($loop->index % 5) + 1);
                    $viewUrl = route('profiles.show', $profile->id);
                @endphp

                <div class="profile-tile" tabindex="0" data-id="{{ $profile->id }}" data-name="{{ $profile->name }}"
                    data-view-url="{{ $viewUrl }}">
                    <div class="avatar {{ $colorClass }}">
                        @if ($profile->photo)
                            <img src="{{ asset($profile->photo) }}" alt="{{ $profile->name }}"
                                style="width:100%; height:100%; object-fit:cover; border-radius:8px;">
                        @else
                            <div class="initial">{{ $initials }}</div>
                        @endif
                    </div>
                    <div class="profile-name">
                        <h5><b>{{ $profile->name ?? 'Unnamed' }}</b></h5>
                    </div>
                    <div class="profile-actions">
                        <a href="{{ $viewUrl }}" class="btn btn-outline-secondary btn-sm" onclick="event.stopPropagation();">
                            <i class="fa-regular fa-eye"></i>
                        </a>
                        <a href="{{ route('admin.profiles.edit', $profile) }}" class="btn btn-outline-primary btn-sm" onclick="event.stopPropagation();">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <form action="{{ route('admin.profiles.destroy', $profile) }}" method="POST" class="d-inline" onClick="event.stopPropagation();">
                            @csrf
                            @method('DELETE')
                            <button type="button" class="btn btn-outline-danger btn-sm" data-delete-confirm
                                data-name="{{ $profile->name }}">
                                <i class="fa-regular fa-trash-can"></i>
                            </button>
                        </form>
                    </div>
                </div>
            @empty
                <p>No profiles found.</p>
            @endforelse
        </div>
    </div>

    <script>
        document.querySelectorAll('.profile-tile').forEach(tile => {
            tile.addEventListener('click', () => {
                const url = tile.dataset.viewUrl;
                if (url) window.location.href = url;
            });

            tile.addEventListener('keydown', (ev) => {
                if (ev.key === 'Enter' || ev.key === ' ') {
                    ev.preventDefault();
                    tile.click();
                }
            });
        });

        document.querySelectorAll('[data-delete-confirm]').forEach((button) => {
            button.addEventListener('click', () => {
                const name = button.dataset.name || 'this profile';
                if (confirm(`Delete ${name}? This cannot be undone.`)) {
                    button.closest('form').submit();
                }
            });
        });
    </script>
@endsection
