<!DOCTYPE html>
<html lang="en">
<head>
    <base href="../../"/>
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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700"/>
    <link href="{{ asset('plugins/global/plugins.bundle.css') }}" rel="stylesheet" type="text/css"/>
    <link rel="shortcut icon" href="{{ asset('media/logos/favicon.ico') }}"/>
    <link href="{{ asset('css/style.bundle.css') }}" rel="stylesheet" type="text/css"/>
</head>

<body id="kt_body" class="app-blank">
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

<div class="d-flex flex-column flex-root" id="kt_app_root">
    <div class="d-flex flex-column flex-lg-row flex-column-fluid">

        <div class="d-flex flex-column flex-lg-row-auto bg-primary w-xl-600px">
            <div class="d-flex flex-column align-items-center justify-content-center text-center h-100 w-100 p-5">
                <a href="{{ route('login') }}" class="">
                    <img alt="Logo" src="media/logo-rumah-sakit.png" class="h-250px h-lg-250px"/>
                </a>
                <h1 class="fw-bold text-white fs-2qx pb-5 pb-md-10">
                    RS DELTA SURYA SIDOARJO
                </h1>
                <p class="fw-semibold fs-2 text-white">
                    SISTEM INFORMASI RUMAH SAKIT
                </p>
            </div>
        </div>

        <div class="d-flex flex-column flex-lg-row-fluid py-10">
            <div class="d-flex flex-center flex-column flex-column-fluid">
                <div class="w-lg-500px p-10 p-lg-15 mx-auto">
                    <form class="form w-100" novalidate="novalidate" id="kt_sign_in_form" method="POST"
                          action="{{ route('login') }}">
                        @csrf
                        <div class="text-center mb-10">
                            <h1 class="text-dark mb-3">Silahkan masuk untuk melanjutkan.</h1>
                        </div>
                        <div class="fv-row mb-10">
                            <label class="form-label fs-6 fw-bold text-dark">Email</label>
                            <input class="form-control form-control-lg form-control-solid" type="email"
                                   name="email" autocomplete="off"/>
                        </div>
                        <div class="fv-row mb-10">
                            <div class="d-flex flex-stack mb-2">
                                <label class="form-label fw-bold text-dark fs-6 mb-0">Password</label>
                            </div>
                            <input class="form-control form-control-lg form-control-solid" type="password"
                                   name="password" autocomplete="off"/>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-lg btn-primary w-100 mb-5">
                                <span class="indicator-label">Sign in</span>
                                <span class="indicator-progress">Please wait...
                                <span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="{{ asset('plugins/global/plugins.bundle.js') }}"></script>
<script src="{{ asset('js/scripts.bundle.js') }}"></script>
<script src="{{ asset('js/custom/authentication/sign-in/general.js') }}"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

    @if (session('error'))
    Swal.fire({
        icon: 'error',
        title: 'Login Gagal',
        text: '{{ session('error') }}',
        confirmButtonText: 'OK',
        backdrop: false
    });
    @endif
</script>
</body>

</html>
