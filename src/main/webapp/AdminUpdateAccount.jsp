<%@ page import="org.example.demo3.connection.ConnectionDB" %>
<%@ page import="org.example.demo3.admin.AdminDAO" %>
<%@ page import="org.example.demo3.admin.Admin" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8"/>


    <title>Admin account settings</title>


    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css"/>
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="assets/css/demo.css"/>

    <!-- Helpers -->
    <script src="assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="assets/js/config.js"></script>
</head>

<body>
<%
    // Retrieve the book ID from the request parameter

    // Retrieve the current book's information from the database using the book ID
    ConnectionDB connectionDB = new ConnectionDB();
    AdminDAO adminDAO = new AdminDAO(connectionDB);
    Admin admin;
    try {
        admin = adminDAO.getAdminById((String) session.getAttribute("adminId"));
        System.out.println(admin.toString());
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

                    <span class="app-brand-text demo menu-text fw-bolder ms-2">My Bookstore</span>
                </a>
            </div>


            <ul class="menu-inner py-1">
                <!-- Dashboard -->
                <li class="menu-item">
                    <a href="AdminManagePage.jsp" class="menu-link">
                        <div>💼 Dashboard</div>
                    </a>
                </li>


                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Pages</span>
                </li>

                <li class="menu-item active open">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <div>👨‍💼 Account Settings</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item active">
                            <a href="AdminUpdateAccount.jsp" class="menu-link">
                                <div>My Account</div>
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

                <li class="menu-header small text-uppercase"><span class="menu-header-text">LOG OUT</span></li>
                <li class="menu-item">
                    <a href="index.html" class="menu-link" id="logoutLink">
                        <div>🚪 Log Out</div>
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
                    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Account Settings /</span>My Account
                    </h4>

                    <div class="row">
                        <div class="col-md-12">
                            <ul class="nav nav-pills flex-column flex-md-row mb-3">
                                <li class="nav-item">
                                    <a class="nav-link active">My Profile</a>
                                </li>
                            </ul>
                            <div class="card mb-4">
                                <h5 class="card-header">Profile Details</h5>
                                <!-- Account -->

                                <hr class="my-0"/>
                                <div class="card-body">
                                    <form method="POST" action="adminServlet">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= admin.getID() %>">
                                        <div class="row">
                                            <div class="mb-3 col-md-6">
                                                <label for="password" class="form-label">PASSWORD</label>
                                                <input
                                                        class="form-control"
                                                        type="password"
                                                        name="password"
                                                        id="password"
                                                        value="<%=admin.getPassword()%>"/>
                                            </div>


                                            <div class="mb-3 col-md-6">
                                                <label for="fullname" class="form-label">FULLNAME</label>
                                                <input
                                                        class="form-control"
                                                        type="text"
                                                        id="fullname"
                                                        name="fullname"
                                                        value="<%=admin.getFullName()%>"
                                                        placeholder="Admin Name"
                                                />
                                            </div>


                                            <div class="mb-3 col-md-6">
                                                <label for="dob" class="form-label">DOB</label>
                                                <input
                                                        type="text"
                                                        class="form-control"
                                                        id="dob"
                                                        name="dob"
                                                        value="<%=admin.getDOB()%>"
                                                />
                                            </div>
                                        </div>
                                        <div class="mt-2">
                                            <button type="submit" class="btn btn-primary me-2">Save changes</button>
                                            <button type="reset" class="btn btn-outline-secondary">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                                <!-- /Account -->

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
<!-- build:js assets/vendor/js/core.js -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>


<script src="assets/vendor/js/menu.js"></script>


<!-- Main JS -->
<script src="assets/js/main.js"></script>

<script>
    document.getElementById('logoutLink').addEventListener('click', function(event) {
        event.preventDefault();

        // Make an AJAX request to a server-side script to clear the session
        fetch('clearSession.jsp')
            .then(function(response) {
                // If the request was successful, navigate to the logout page
                if (response.ok) {
                    window.location.href = 'index.html';
                } else {
                    console.error('Failed to clear session');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
            });
    });
</script>

</body>
</html>
