<!DOCTYPE html>
<html lang="en">

<head>
    <base href=""/>
    <title>RS DELTA SURYA</title>
    <meta charset="utf-8"/>
    <meta name="description" content="Saul HTML Free - Bootstrap 5 HTML Multipurpose Admin Dashboard Theme"/>
    <meta name="keywords"
          content="Saul, bootstrap, bootstrap 5, dmin themes, free admin themes, bootstrap admin, bootstrap dashboard"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta property="og:locale" content="en_US"/>
    <meta property="og:type" content="article"/>
    <meta property="og:title" content="Saul HTML Free - Bootstrap 5 HTML Multipurpose Admin Dashboard Theme"/>
    <meta property="og:url" content="https://keenthemes.com/products/saul-html-pro"/>
    <meta property="og:site_name" content="Keenthemes | Saul HTML Free"/>
    <link rel="canonical" href="https://preview.keenthemes.com/saul-html-free"/>
    <link rel="shortcut icon" href="assets/media/logos/favicon.ico"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700"/>
    <link href="{{ asset('plugins/global/plugins.bundle.css') }}" rel="stylesheet" type="text/css"/>
    <link href="{{ asset('css/style.bundle.css') }}" rel="stylesheet" type="text/css"/>
    <style>
    </style>
</head>

<body id="kt_app_body" data-kt-app-header-fixed="true" data-kt-app-header-fixed-mobile="true"
      data-kt-app-sidebar-enabled="true" data-kt-app-sidebar-fixed="true" data-kt-app-sidebar-hoverable="true"
      data-kt-app-sidebar-push-toolbar="true" data-kt-app-sidebar-push-footer="true" data-kt-app-toolbar-enabled="true"
      data-kt-app-aside-enabled="true" data-kt-app-aside-fixed="true" data-kt-app-aside-push-toolbar="true"
      data-kt-app-aside-push-footer="true" class="app-default">
<!--begin::Theme mode setup on page load-->
<script>
    var defaultThemeMode = "light";
    var themeMode;
    if (document.documentElement) {
        if (document.documentElement.hasAttribute("data-bs-theme-mode")) {
            themeMode = document.documentElement.getAttribute("data-bs-theme-mode");
        } else {
            if (localStorage.getItem("data-bs-theme") !== null) {
                themeMode = localStorage.getItem("data-bs-theme");
            } else {
                themeMode = defaultThemeMode;
            }
        }
        if (themeMode === "system") {
            themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
        }
        document.documentElement.setAttribute("data-bs-theme", themeMode);
    }
</script>
<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
    <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
        <div id="kt_app_header" class="app-header d-flex flex-column flex-stack">
            <div class="d-flex align-items-center flex-stack flex-grow-1">
                {{-- Logo & Sidebar toggle --}}
                <div class="app-header-logo d-flex align-items-center flex-stack px-lg-11 mb-2" id="kt_app_header_logo">
                    <div class="btn btn-icon btn-active-color-primary w-35px h-35px ms-3 me-2 d-flex d-lg-none"
                         id="kt_app_sidebar_mobile_toggle">
                        <i class="ki-duotone ki-abstract-14 fs-2">
                            <span class="path1"></span>
                            <span class="path2"></span>
                        </i>
                    </div>
                    <a href="{{ url('/') }}" class="app-sidebar-logo">
                        <img alt="Logo" src="{{ asset('media/logo-rumah-sakit.png') }}"
                             class="h-30px theme-light-show"/>
                    </a>
                    <div style="color:black;">
                        DELTA SURYA HUSADA
                    </div>
                    <div id="kt_app_sidebar_toggle"
                         class="app-sidebar-toggle btn btn-sm btn-icon btn-color-warning me-n2 d-none d-lg-flex"
                         data-kt-toggle="true" data-kt-toggle-state="active" data-kt-toggle-target="body"
                         data-kt-toggle-name="app-sidebar-minimize">
                        <i class="ki-duotone ki-exit-left fs-2x rotate-180">
                            <span class="path1"></span>
                            <span class="path2"></span>
                        </i>
                    </div>
                </div>

                {{-- Tombol logout di kanan --}}
                <form action="{{ route('logout') }}" method="POST" class="me-20">
                    @csrf
                    <button type="submit" class="btn btn-sm btn-danger">
                        <i class="ki-duotone ki-logout fs-3 me-1"></i> Logout
                    </button>
                </form>
            </div>

            <div class="app-header-separator"></div>
        </div>


        <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
            <div id="kt_app_sidebar" class="app-sidebar flex-column" data-kt-drawer="true"
                 data-kt-drawer-name="app-sidebar" data-kt-drawer-activate="{default: true, lg: false}"
                 data-kt-drawer-overlay="true" data-kt-drawer-width="250px" data-kt-drawer-direction="start"
                 data-kt-drawer-toggle="#kt_app_sidebar_mobile_toggle">
                <div
                    class="d-flex flex-column justify-content-between h-100 hover-scroll-overlay-y my-2 d-flex flex-column"
                    id="kt_app_sidebar_main" data-kt-scroll="true" data-kt-scroll-activate="true"
                    data-kt-scroll-height="auto" data-kt-scroll-dependencies="#kt_app_header"
                    data-kt-scroll-wrappers="#kt_app_main" data-kt-scroll-offset="5px">
                    <div id="#kt_app_sidebar_menu" data-kt-menu="true" data-kt-menu-expand="false"
                         class="flex-column-fluid menu menu-sub-indention menu-column menu-rounded menu-active-bg mb-7">
                        @if (\Illuminate\Support\Facades\Auth::user()->role->slug == "dokter" || \Illuminate\Support\Facades\Auth::user()->role->slug == "apoteker")
                            <div data-kt-menu-trigger="click" class="menu-item here show menu-accordion">
                                <span class="menu-link">
                                    <span class="menu-icon">
                                        <i class="ki-duotone ki-element-11 fs-1">
                                            <span class="path1"></span>
                                            <span class="path2"></span>
                                            <span class="path3"></span>
                                            <span class="path4"></span>
                                        </i>
                                    </span>
                                    <span class="menu-title">Pemeriksaan</span>
                                    <span class="menu-arrow"></span>
                                </span>
                                <div class="menu-sub menu-sub-accordion">
                                    <div class="menu-item">
                                        <a class="menu-link {{ request()->routeIs('examination.*') ? 'active' : '' }}"
                                           href="{{ route('examination.index') }}">
                                            <span class="menu-bullet">
                                                <span class="bullet bullet-dot"></span>
                                            </span>
                                            <span class="menu-title">Input Data</span>
                                        </a>
                                    </div>

                                </div>
                            </div>
                        @endif
                        @if (\Illuminate\Support\Facades\Auth::user()->role->slug == "admin")
                            <div data-kt-menu-trigger="click" class="menu-item here show menu-accordion">
                                <span class="menu-link">
                                    <span class="menu-icon">
                                        <i class="ki-duotone ki-element-11 fs-1">
                                            <span class="path1"></span>
                                            <span class="path2"></span>
                                            <span class="path3"></span>
                                            <span class="path4"></span>
                                        </i>
                                    </span>
                                    <span class="menu-title">Master</span>
                                    <span class="menu-arrow"></span>
                                </span>
                                <div class="menu-sub menu-sub-accordion">
                                    <div class="menu-item">
                                        <a class="menu-link {{ request()->routeIs('user.*') ? 'active' : '' }}"
                                           href="{{ route('user.index') }}">
                                            <span class="menu-bullet">
                                                <span class="bullet bullet-dot"></span>
                                            </span>
                                            <span class="menu-title">User</span>
                                        </a>
                                    </div>
                                    <div class="menu-item">
                                        <a class="menu-link {{ request()->routeIs('medicine.*') ? 'active' : '' }}"
                                           href="{{ route('medicine.index') }}">
                                            <span class="menu-bullet">
                                                <span class="bullet bullet-dot"></span>
                                            </span>
                                            <span class="menu-title">Obat</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                                <div data-kt-menu-trigger="click" class="menu-item here show menu-accordion">
                                <span class="menu-link">
                                    <span class="menu-icon">
                                        <i class="ki-duotone ki-element-11 fs-1">
                                            <span class="path1"></span>
                                            <span class="path2"></span>
                                            <span class="path3"></span>
                                            <span class="path4"></span>
                                        </i>
                                    </span>
                                    <span class="menu-title">Log</span>
                                    <span class="menu-arrow"></span>
                                </span>
                                    <div class="menu-sub menu-sub-accordion">
                                        <div class="menu-item">
                                            <a class="menu-link {{ request()->routeIs('log.*') ? 'active' : '' }}"
                                               href="{{ route('log.index') }}">
                                            <span class="menu-bullet">
                                                <span class="bullet bullet-dot"></span>
                                            </span>
                                                <span class="menu-title">Log Aktivitas User</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                        @endif
                    </div>
                </div>
            </div>
            <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                <div class="d-flex flex-column flex-column-fluid">
                    <div id="kt_app_toolbar" class="app-toolbar pt-5">
                        <div id="kt_app_toolbar_container"
                             class="app-container container-fluid d-flex align-items-stretch">
                            <div class="app-toolbar-wrapper d-flex flex-stack flex-wrap gap-4 w-100">
                                <div class="page-title d-flex flex-column gap-1 me-3 mb-2">
                                    <h1
                                        class="page-heading d-flex flex-column justify-content-center text-dark fw-bolder fs-1 lh-0">
                                        @yield('title')
                                    </h1>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div id="kt_app_content" class="app-content">
                        <div id="kt_app_content_container" class="app-container container-fluid">
                            @yield('content')
                        </div>
                    </div>
                </div>
                {{-- <div id="kt_app_footer"
                    class="app-footer align-items-center justify-content-center justify-content-md-between flex-column flex-md-row py-3">
                    <div class="text-dark order-2 order-md-1">
                        <span class="text-muted fw-semibold me-1">2023&copy;</span>
                        <a href="https://keenthemes.com" target="_blank"
                            class="text-gray-800 text-hover-primary">Keenthemes</a>
                    </div>
                    <ul class="menu menu-gray-600 menu-hover-primary fw-semibold order-1">
                    </ul>
                </div> --}}
            </div>
        </div>
    </div>
</div>
<div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true">
    <i class="ki-duotone ki-arrow-up">
        <span class="path1"></span>
        <span class="path2"></span>
    </i>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="{{ asset('plugins/global/plugins.bundle.js') }}"></script>
<script src="{{ asset('js/scripts.bundle.js') }}"></script>

<script>
    var hostUrl = "assets/";

    @if (session('error'))
    setTimeout(() => {
        Swal.fire({
            icon: 'error',
            title: 'Gagal',
            html: `{!! session('error') !!}`,
            backdrop: false,
        });
    }, 500);
    @endif
    @if (session('success'))
    setTimeout(() => {
        Swal.fire({
            icon: 'success',
            title: 'Berhasil',
            text: '{{ session('success') }}',
            backdrop: false,
        });
    }, 500);
    @endif

</script>
@if ($errors->any())
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const errs = @json($errors->all());
            Swal.fire({
                icon: 'error',
                title: 'Validasi gagal',
                backdrop: false,
                html: '<ul style="text-align:left;margin:0;padding-left:18px;">'
                    + errs.map(e => `<li>${e}</li>`).join('')
                    + '</ul>'
            });
        });
    </script>
@endif
</body>
</html>
