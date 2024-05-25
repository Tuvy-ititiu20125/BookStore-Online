<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <title>Login Admin</title>
    <meta charset="utf-8"/>

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" type="text/css" href="assets/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" type="text/css" href="assets/vendor/css/core.css" class="template-customizer-core-css"/>
    <link rel="stylesheet" type="text/css" href="assets/vendor/css/theme-default.css"
         />
    <link rel="stylesheet" type="text/css" href="assets/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet" type="text/css" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css">

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css"/>
    <!-- Helpers -->
    <script src="assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="assets/js/config.js"></script>
</head>

<body>
<!-- Content -->

<div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
            <!-- Register -->
            <div class="card">
                <div class="card-body">
                    <!-- Logo -->
                    <div class="app-brand justify-content-center">
                        <a href="index.html" class="app-brand-link gap-2">

                            <span class="app-brand-text demo text-body fw-bolder">👨‍💼 Admin Login</span>
                        </a>
                    </div>
                    <!-- /Logo -->

                    <h4 class="mb-2">Welcome admin! 👋</h4>
                    <p class="mb-4">Please sign-in to your account and start managing the store</p>

                    <form action="loginServlet" method="POST">
                        <div class="mb-3">
                            <label for="id" class="form-label">Username</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="id"
                                    name="id"
                                    placeholder="Username"
                                    autofocus
                            />

                        </div>
                        <div class="mb-3 form-password-toggle">
                            <div class="d-flex justify-content-between">
                                <label class="form-label" for="password">Password</label>
                                <small>Forgot Password?</small>
                            </div>
                            <div class="input-group input-group-merge">
                                <input
                                        type="password"
                                        id="password"
                                        class="form-control"
                                        name="password"
                                />
                            </div>
                        </div>
                        <div class="mb-3">
                            <button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
