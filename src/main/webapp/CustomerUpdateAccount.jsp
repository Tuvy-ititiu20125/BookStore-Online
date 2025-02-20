<%@ page import="org.example.demo3.connection.ConnectionDB" %>
<%@ page import="org.example.demo3.admin.AdminDAO" %>
<%@ page import="org.example.demo3.admin.Admin" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.example.demo3.customer.Customer" %>
<%@ page import="org.example.demo3.customer.CustomerDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta charset="utf-8" />


  <title>Admin account settings</title>


  <!-- Icons. Uncomment required icon fonts -->
  <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="assets/css/demo.css" />

  <!-- Helpers -->
  <script src="assets/vendor/js/helpers.js"></script>

  <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
  <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
  <script src="assets/js/config.js"></script>
</head>

<body>
<%
  // Retrieve the book ID from the request parameter
  String customerId = request.getParameter("id");

  // Retrieve the current book's information from the database using the book ID
  ConnectionDB connectionDB = new ConnectionDB();
  CustomerDAO customerDAO = new CustomerDAO(connectionDB);
  Customer customer;
  try {
    customer = customerDAO.getCustomerById((String) session.getAttribute("customerId"));
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
        <a href="CustomerManagePage.jsp" class="app-brand-link">

          <span class="app-brand-text demo menu-text fw-bolder ms-2">My Bookstore</span>
        </a>
      </div>


      <ul class="menu-inner py-1">
        <!-- Dashboard -->
        <li class="menu-item">
          <a href="CustomerManagePage.jsp" class="menu-link">
            <div>💼  Dashboard</div>
          </a>
        </li>




        <li class="menu-header small text-uppercase">
          <span class="menu-header-text">Pages</span>
        </li>

        <li class="menu-item active">
          <a href="CustomerUpdateAccount.jsp" class="menu-link">
            <div>👨‍💼 Account Settings</div>
          </a>
        </li>

        <!-- Components -->
        <li class="menu-header small text-uppercase"><span class="menu-header-text">LIBRARY</span></li>

        <li class="menu-item">
          <a href="viewOrder.jsp" class="menu-link ">
            <div>📕 My Books</div>
          </a>

        </li>

        <!-- Forms & Tables -->
        <li class="menu-header small text-uppercase"><span class="menu-header-text">BOOK STORE</span></li>
        <!-- Tables -->
        <li class="menu-item">
          <a href="customerBookList.jsp" class="menu-link">
            <div>📚 Library</div>
          </a>
        </li>
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
          <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Account Settings /</span>My Account</h4>

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

                <hr class="my-0" />
                <div class="card-body">
                  <form method="POST" action="customerServlet">
                    <input type="hidden" name="action" value="updateCustomer">
                    <input type="hidden" name="id" value="<%= customer.getID() %>">
                    <div class="row">
                      <div class="mb-3 col-md-6">
                        <label for="password" class="form-label">PASSWORD</label>
                        <input
                                class="form-control"
                                type="password"
                                name="password"
                                id="password"
                                value="<%=customer.getPassword()%>" />


                      </div>


                      <div class="mb-3 col-md-6">
                        <label for="firstname" class="form-label">FIRSTNAME</label>
                        <input
                                class="form-control"
                                type="text"
                                id="firstname"
                                name="firstname"
                                value="<%=customer.getFirstName()%>"
                                placeholder="Customer Name"
                        />
                      </div>

                      <div class="mb-3 col-md-6">
                        <label for="lastname" class="form-label">LASTNAME</label>
                        <input
                                type="text"
                                class="form-control"
                                id="lastname"
                                name="lastname"
                                value="<%=customer.getLastName()%>"
                        />
                      </div>


                      <div class="mb-3 col-md-6">
                        <label for="dob" class="form-label">DOB</label>
                        <input
                                type="text"
                                class="form-control"
                                id="dob"
                                name="dob"
                                value="<%=customer.getDOB()%>"
                        />
                      </div>

                      <div class="mb-3 col-md-6">
                        <label for="amount" class="form-label">AMOUNT IN ACCOUNT</label>
                        <input
                                type="number"
                                class="form-control"
                                id="amount"
                                name="amount"
                                value="<%=customer.getAmountInAccount()%>"
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

<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="assets/js/main.js"></script>



</body>
</html>
