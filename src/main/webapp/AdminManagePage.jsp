<%@ page import="org.example.demo3.connection.ConnectionDB" %>
<%@ page import="org.example.demo3.admin.AdminDAO" %>
<%@ page import="org.example.demo3.admin.Admin" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html
>
<head>
    <meta charset="utf-8" />


    <title>Admin Dashboard</title>


    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <link rel="stylesheet" href="assets/vendor/libs/apex-charts/apex-charts.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="assets/js/config.js"></script>
</head>

<body>
<%
    // Retrieve the book ID from the request parameter
    String adminId = request.getParameter("id");

    // Retrieve the current book's information from the database using the book ID
    ConnectionDB connectionDB = new ConnectionDB();
    AdminDAO adminDAO = new AdminDAO(connectionDB);
    Admin admin;
    try {
        admin = adminDAO.getAdminById((String) session.getAttribute(adminId));
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
            <div class="app-brand demo">
                <a href="AdminManagePage.jsp" class="app-brand-link">

                    <span class="app-brand-text demo menu-text fw-bolder ms-2">My bookstore</span>
                </a>


            </div>


            <ul class="menu-inner py-1">
                <!-- Dashboard -->
                <li class="menu-item active">
                    <a href="AdminManagePage.jsp" class="menu-link">
                        <div>💼  Dashboard</div>
                    </a>
                </li>

                <!-- Layouts -->

                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Pages</span>
                </li>

                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <div>👨‍💼 Account Settings</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href="AdminUpdateAccount.jsp" class="menu-link">
                                <div >My Account</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="CustomerList1.jsp" class="menu-link">
                                <div>Customers</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- Forms & Tables -->
                <li class="menu-header small text-uppercase"><span class="menu-header-text">BOOK STORE</span></li>
                <!-- Tables -->
                <li class="menu-item">
                    <a href="BookList.jsp" class="menu-link">
                        <div>📚 Library</div>
                    </a>
                </li>
            </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->

            <nav
                    class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                    id="layout-navbar"
            >
                <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                    <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                        🟣
                    </a>
                </div>

                <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">


                </div>
            </nav>

            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->

                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="row">
                        <div class="col-lg-8 mb-4 order-0">
                            <div class="card">
                                <div class="d-flex align-items-end row">
                                    <div class="col-sm-7">
                                        <div class="card-body">
                                            <h5 class="card-title text-primary">Good morning <%=admin.getFullName()%>! 🎉</h5>
                                            <p class="mb-4">
                                                Update new book regularly for your book reader 🤗
                                            </p>

                                        </div>
                                    </div>
                                    <div class="col-sm-5 text-center text-sm-left">
                                        <div class="card-body pb-0 px-0 px-md-4">
                                            <img
                                                    src="assets/img/illustrations/man-with-laptop-light.png"
                                                    height="340"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
                            <div class="row">
                                <div class="col-6 mb-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="card-title d-flex align-items-start justify-content-between">
                                                <div class="avatar flex-shrink-0">
                                                    🙎‍♂️
                                                </div>
                                            </div>
                                            <span class="fw-semibold d-block mb-1">Total Customers</span>
                                            <h3 id="totalCustomer" class="card-title text-nowrap mb-2"></h3>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 mb-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="card-title d-flex align-items-start justify-content-between">
                                                <div class="avatar flex-shrink-0">
                                                    📘
                                                </div>
                                            </div>
                                            <span class="fw-semibold d-block mb-1">Books in store</span>
                                            <h3 id = "totalBooks" class="card-title mb-2"></h3>
                                        </div>
                                    </div>
                                </div>

                                <!-- </div>
                <div class="row"> -->
                            </div>
                        </div>



                    </div>

                </div>
                <!-- / Content -->



                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>
</div>
<!-- / Layout wrapper -->



<!-- Core JS -->

<script src="assets/vendor/libs/jquery/jquery.js"></script>

<script src="assets/vendor/js/menu.js"></script>


<!-- Main JS -->
<script src="assets/js/main.js"></script>

<script>
    $(document).ready(function() {
        // First AJAX call
        $.ajax({
            type: 'POST',
            url: 'bookServlet1',
            data: { action: 'countTotalCustomer' },
            success: function(data) {
                $('#totalCustomer').html(data); // Update the element with the received value
            },
            error: function() {
                console.log('Error fetching total customer count.');
            }
        });


        // Third AJAX call
        $.ajax({
            type: 'POST',
            url: 'bookServlet1',
            data: { action: 'countTotalBooks' },
            success: function(data) {
                $('#totalBooks').html(data); // Update the element with the received value
            },
            error: function() {
                console.log('Error fetching active customer count.');
            }
        });
    });
</script>
</body>
</html>
