<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css">
    <link rel="icon" type="image/x-icon" href="/admin/assets/images/fav.png">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <!-- Event -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css">
    <!-- End -->
    <link rel="stylesheet" href="/admin/assets/css/style.css">

    <!-- ✅ Toastr CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <title>@yield('title') - Hatch Social</title>

    @yield('styles')
</head>

<body>
    <section class="admin">
        <div class="sidebar">
            <div>
                <div class="head-div">
                    <img src="/admin/assets/images/logo.png" class="sidebar-logo" />
                    <button id="closeBtn"><i class="fa-solid fa-xmark"></i></button>
                </div>

                <h3 class="sidebar-h3">GENERAL</h3>
                <div class="sidebar-links1">
                    @if (auth()->user()->role == 'superadmin' || auth()->user()->role == 'admin')
                        <a href="{{ route('dashboard') }}"
                            class="{{ request()->routeIs('dashboard') ? 'active' : '' }}">
                            <img src="/admin/assets/images/icon1.png" /> Dashboard
                        </a>
                        <a href="{{ route('users.index') }}"
                            class="{{ request()->routeIs('users.*') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon4.png') }}" /> Users
                        </a>
                        <a href="{{ route('interests.index') }}"
                            class="{{ request()->routeIs('interests.*') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon6.png') }}" /> Interests
                        </a>
                        <a href="{{ route('reports.index') }}"
                            class="{{ request()->routeIs('reports.*') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon13.png') }}" /> Reports
                        </a>
                        <a href="{{ route('package.index') }}"
                            class="{{ request()->routeIs('package.*') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon1.png') }}" /> Subscription Packages
                        </a>
                        <a href="{{ route('chat') }}" class="{{ request()->routeIs('chat') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon1.png') }}" /> Chats
                        </a>
                    @endif
                    @if (auth()->user()->role == 'user')
                        @php
                            $profileId = request()->segment(3) ?? auth()->user()->id;
                        @endphp
                        <a href="{{ route('admin.profiles.index') }}"
                            class="{{ request()->routeIs(['admin.profiles.index', 'profiles.show']) ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon1.png') }}" /> Profiles
                        </a>
                        <a href="{{ route('profile_chat_list', $profileId) }}"
                            class="{{ request()->routeIs('profile_chat_list') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon1.png') }}" /> Chats Support
                        </a>
                        <a href="{{ route('profile_wallet', $profileId) }}"
                            class="{{ request()->routeIs('profile_wallet') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon1.png') }}" /> Wallet & Withdrawl
                        </a>
                        <a href="{{ route('admin.coupons.index', $profileId) }}"
                            class="{{ request()->routeIs('admin.coupons.*') ? 'active' : '' }}">
                            <img src="{{ asset('admin/assets/images/icon1.png') }}" /> Coupon
                        </a>
                    @endif
                </div>
            </div>

            <div>
                <h3 class="sidebar-h3">SYSTEM</h3>
                <div class="sidebar-links1">
                    <a href="#"
                        onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                        <i class="fa-light fa-left-from-bracket"></i> Logout
                    </a>

                    <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                        @csrf
                    </form>
                </div>
            </div>
        </div>
        <div class="main-div">
            <button id="toggleBtn">
                <i class="fa-solid fa-bars"></i>
            </button>

            @yield('content')

            <div>
                <p class="copyright-admin">Copyright © 2024 Hatch Social All Rights Reserved.</p>
            </div>
        </div>
    </section>

    <!-- JS Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/locale-all.js"></script>

    <!-- ✅ Toastr JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <!-- Custom Scripts -->
    <script>
        $('.owl-carousel').owlCarousel({
            loop: false,
            margin: 10,
            nav: false,
            dots: false,
            autoplaySpeed: 2000,
            autoplay: true,
            responsive: {
                0: {
                    items: 1
                },
                600: {
                    items: 3
                },
                1000: {
                    items: 6
                }
            }
        });

        const toggleBtn = document.querySelector('#toggleBtn');
        const closeBtn = document.querySelector('#closeBtn');
        const mainSection = document.querySelector('.admin');

        toggleBtn.addEventListener('click', () => {
            mainSection.classList.toggle('show');
        });
        closeBtn.addEventListener('click', () => {
            mainSection.classList.remove('show');
        });

        // ✅ Toastr flash messages
        @if (session('success'))
            toastr.success("{{ session('success') }}");
        @endif
        @if (session('error'))
            toastr.error("{{ session('error') }}");
        @endif
    </script>

    @yield('scripts')
</body>

</html>
