<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Book List</title>

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
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
            <div class="app-brand demo">
                <a href="CustomerManagePage.jsp" class="app-brand-link">
                    <span class="app-brand-text demo menu-text fw-bolder ms-2">My Bookstore</span>
                </a>

            </div>

            <!-- Layouts -->
            <ul class="menu-inner py-1">

                <li class="menu-item">
                    <a href="CustomerManagePage.jsp" class="menu-link">
                        <div>💼 Dashboard</div>
                    </a>
                </li>


                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Pages</span>
                </li>

                <li class="menu-item">
                    <a href="#" class="menu-link">
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
                <li class="menu-item  active">
                    <a href="customerBookList.jsp" class="menu-link">
                        <div>📚 Library</div>
                    </a>
                </li>
            </ul>
        </aside>


        <div class="layout-page s003">
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

            <div class="content-wrapper">

                <div class="container-xxl flex-grow-1 container-p-y">
                    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Library /</span> Books in store</h4>
                    <div class="card">
                        <div class="table-responsive text-nowrap">
                            <form id="bookForm" action="orderServlet" method="POST">

                                <table class="table">

                                    <thead>
                                    <tr>
                                        <th>Select</th>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Publication Date</th>
                                        <th>Version</th>
                                        <th>Genre</th>
                                        <th>Price</th>
                                        <th>Type</th>
                                    </tr>
                                    </thead>
                                    <tbody id="bookTableBody"></tbody>
                                    <input type="hidden" name="customerId"
                                           value="<%= session.getAttribute("customerId") %>"/>
                                    <input type="hidden" name="action" value="saveOrder"/>
                                    <button class="btn btn-primary d-grid" type="submit">Submit Order</button>


                                </table>
                            </form>


                        </div>
                    </div>

                    <hr class="my-5"/>


                </div>

                <div class="content-backdrop fade"></div>


            </div>
        </div>

    </div>

    <div class="layout-overlay layout-menu-toggle"></div>
</div>
<!-- Content wrapper -->

<!-- / Layout page -->


<!-- Overlay -->


<!-- / Layout wrapper -->
<!-- build:js assets/vendor/js/core.js -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>


<script src="assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="assets/js/main.js"></script>


<script>
    function fetchBookList() {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "orderServlet");
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var books = JSON.parse(xhr.responseText);
                updateBookTable(books);
            }
        };
        xhr.send("action=viewBook");
    }

    function updateBookTable(books) {
        var tableBody = document.getElementById("bookTableBody");

        // Clear the table body
        tableBody.innerHTML = "";

        // Add the book list to the table
        for (var i = 0; i < books.length; i++) {
            var book = books[i];
            var row = tableBody.insertRow(-1);

            // Add a checkbox for selecting the book
            var selectCell = row.insertCell(0);
            selectCell.innerHTML = '<input type="checkbox" name="bookIDs" value="' + book.ID + '" />';

            var idCell = row.insertCell(1);
            idCell.innerHTML = book.ID;

            var titleCell = row.insertCell(2);
            titleCell.innerHTML = book.BookTitle;

            var authorCell = row.insertCell(3);
            authorCell.innerHTML = book.AuthorName;

            var pubDateCell = row.insertCell(4);
            pubDateCell.innerHTML = book.PublicationDate;

            var versionCell = row.insertCell(5);
            versionCell.innerHTML = book.Version;

            var genreCell = row.insertCell(6);
            genreCell.innerHTML = book.Genre;

            var priceCell = row.insertCell(7);
            priceCell.innerHTML = book.Price;

            var typeCell = row.insertCell(8);
            typeCell.innerHTML = book.Type;
        }
    }

    // Fetch the book list when the page loads
    document.addEventListener("DOMContentLoaded", fetchBookList);
</script>
</body>
</html>
