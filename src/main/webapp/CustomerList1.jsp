<%@ page import="org.example.demo3.customer.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>

    <meta charset="utf-8"/>

    <title>Customer List</title>


    <link href="assets/css/main.css" rel="stylesheet"/>


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

<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
            <div class="app-brand demo">
                <a href="AdminManagePage.jsp" class="app-brand-link">
                    <span class="app-brand-text demo menu-text fw-bolder ms-2">my bookstore</span>
                </a>

                <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
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
                        <div data-i18n="Account Settings">👨‍💼 Account Settings</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href="AdminUpdateAccount.jsp" class="menu-link">
                                <div>My Account</div>
                            </a>
                        </li>

                        <li class="menu-item active">
                            <a href="#" class="menu-link" id="customerMenuItem">
                                <div>Customers</div>
                            </a>
                        </li>
                    </ul>
                </li>


                <!-- Forms & Tables -->
                <li class="menu-header small text-uppercase"><span class="menu-header-text">BOOK STORE</span></li>
                <!-- Forms -->


                <!-- Tables -->
                <li class="menu-item">
                    <a href="BookList.jsp" class="menu-link">
                        <div>📚 Library</div>
                    </a>
                </li>
                <script>
                    window.addEventListener('load', function () {
                        // Check if form has already been submitted in this session
                        var form = document.createElement('form');
                        form.method = 'post';
                        form.action = 'customerServlet';
                        var input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'action';
                        input.value = 'view';
                        form.appendChild(input);
                        document.body.appendChild(form);

                        var customerMenuItem = document.getElementById('customerMenuItem');
                        customerMenuItem.addEventListener('click', function (event) {
                            event.preventDefault();
                            form.submit();
                        });
                        if (!sessionStorage.getItem('formSubmitted')) {
                            customerMenuItem.click();
                            sessionStorage.setItem('formSubmitted', 'true');
                        }

                    });
                </script>
            </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page s003">
            <!-- Navbar -->

            <nav
                    class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme d-flex justify-content-center"
                    id="layout-navbar"
            >
                <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                    <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                        🟣
                    </a>
                </div>

                <!-- Search -->
                <form method="post" action="customerServlet?action=search">
                    <div class="inner-form">
                        <div class="input-field first-wrap">
                            <select class="input-field" name="filter" id="filter">
                                <option value="ID">ID</option>
                                <option value="FirstName">First Name</option>
                                <option value="LastName">Last Name</option>
                            </select>
                        </div>

                        <div class="input-field second-wrap">
                            <input
                                    type="text"
                                    name="value"
                                    id="search-value"
                                    placeholder="Enter search value"
                            />

                        </div>

                        <div class="input-field third-wrap">
                            <button class="btn btn-primary d-grid" type="submit" id="search-button">Search</button>

                        </div>
                    </div>
                </form>
                <!-- /Search -->
                <script src="assets/js/extention/choices.js"></script>
                <script>
                    const choices = new Choices('[data-trigger]',
                        {
                            searchEnabled: false,
                            itemSelectText: '',
                        });

                </script>


            </nav>


            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->

                <div class="container-xxl flex-grow-1 container-p-y">
                    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Customer / </span>Customers In Store
                    </h4>
                    <!-- Basic Bootstrap Table -->
                    <div class="card">
                        <div class="table-responsive text-nowrap">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Password</th>
                                    <th>FirstName</th>
                                    <th>LastName</th>
                                    <th>DOB</th>
                                    <th>Amount</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody id="book-table-body">
                                <% ArrayList<Customer> customers = (ArrayList<Customer>) request.getAttribute("customers");
                                    if (customers != null) {
                                        for (Customer customer : customers) { %>
                                <tr>
                                    <td><%= customer.getID() %>
                                    </td>
                                    <td><%= customer.getPassword() %>
                                    </td>
                                    <td><%= customer.getFirstName() %>
                                    </td>
                                    <td><%= customer.getLastName() %>
                                    </td>
                                    <td><%= customer.getDOB() %>
                                    </td>
                                    <td><%= customer.getAmountInAccount() %>
                                    </td>
                                    <td>
                                        <form method="post" action="customerServlet">
                                            <input type="hidden" name="id" value="<%= customer.getID() %>">
                                            <button class="btn btn-primary d-grid" type="submit" name="action"
                                                    value="remove"
                                                    onclick="return confirm('Are you sure you want to delete this book?')">
                                                Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <% }
                                } %>
                                </tbody>
                            </table>
                        </div>
                    </div>


                    <hr class="my-5"/>


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
<!-- build:js assets/vendor/js/core.js -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>


<script src="assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="assets/js/main.js"></script>
</body>
</html>
