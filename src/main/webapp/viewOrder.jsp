<%@ page import="org.example.demo3.book.Book" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>View Order</title>


    <link href="assets/css/main.css" rel="stylesheet" />


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
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->

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
                    <a href="CustomerUpdateAccount.jsp" class="menu-link">
                        <div>👨‍💼 Account Settings</div>
                    </a>

                </li>

                <!-- Components -->
                <li class="menu-header small text-uppercase"><span class="menu-header-text">LIBRARY</span></li>

                <li class="menu-item active">
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


                <script src="assets/js/extention/choices.js"></script>
                <script>
                    const choices = new Choices('[data-trigger]',
                        {
                            searchEnabled: false,
                            itemSelectText: '',
                        });

                </script>


            </nav>

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->

                <div class="container-xxl flex-grow-1 container-p-y">
                    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">My Books / </span>Total Books </h4>
                    <!-- Basic Bootstrap Table -->
                    <div class="card">
                        <div class="table-responsive text-nowrap">
                            <table class="table">
    <thead>
    <tr>
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
                            <tbody id = "bookTableBody"></tbody>

                                <input type="hidden" name="customerId"
                                       value="<%= session.getAttribute("customerId") %>"/>
  <%-- <tbody>
    <% List<Book> books = (List<Book>) request.getAttribute("booksInOrder");
    if (books != null) {
    for (Book book : books) { %>
    <tr>
        <td><%= book.getId() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= book.getAuthor() %></td>
        <td><%= book.getPublicationDate() %></td>
        <td><%= book.getVersion() %></td>
        <td><%= book.getGenre() %></td>
        <td><%= book.getPrice() %></td>
        <td><%= book.getType() %></td>
        <td>
    </tr>
    <%  }
        } %>
    </tbody> --%>
</table>

                        </div>
                    </div>







                    <hr class="my-5" />











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
<script>
    function fetchBookOrderList(){
        var xhr =  new XMLHttpRequest();
        xhr.open("GET", "orderServlet?action=view");
        xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var books = JSON.parse(xhr.responseText);
                updateBookOrderTable(books);
            }
        };
        xhr.send();
    }

    function updateBookOrderTable(books){
        var tableBody = document.getElementById("bookTableBody");

        tableBody.innerHTML = "";

        for (var i = 0; i<books.length;i++){
            var book = books[i];
            var row = tableBody.insertRow(-1);

            var idCell = row.insertCell(0);
            idCell.innerHTML = book.ID;

            var titleCell = row.insertCell(1);
            titleCell.innerHTML = book.BookTitle;

            var authorCell = row.insertCell(2);
            authorCell.innerHTML = book.AuthorName;

            var pubDateCell = row.insertCell(3);
            pubDateCell.innerHTML = book.PublicationDate;

            var versionCell = row.insertCell(4);
            versionCell.innerHTML = book.Version;

            var genreCell = row.insertCell(5);
            genreCell.innerHTML = book.Genre;

            var priceCell = row.insertCell(6);
            priceCell.innerHTML = book.Price;

            var typeCell = row.insertCell(7);
            typeCell.innerHTML = book.Type;
        }
    }

    document.addEventListener("DOMContentLoaded", fetchBookOrderList);
</script>

</body>

</html>

