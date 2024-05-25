<%@ page import="org.example.demo3.book.Book" %>
<%@ page import="java.util.ArrayList" %>
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
                <li class="menu-item">
                    <a href="AdminManagePage.jsp" class="menu-link">
                        <div>💼 Dashboard</div>
                    </a>
                </li>


                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Pages</span>
                </li>
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <div>👨‍💼 Account Settings</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href="pages-account-settings-account.html" class="menu-link">
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


                <!-- Bookstore Management -->
                <li class="menu-header small text-uppercase"><span class="menu-header-text">Book Store</span></li>


                <!-- Book -->
                <li class="menu-item active">
                    <a href="#" class="menu-link" id="libraryMenuItem">
                        <div>📚 Library</div>
                    </a>
                </li>


            </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page s003">
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


                <!-- Search -->
                <form method="post" action="bookServlet1?action=search">
                    <div class="inner-form">
                        <div class="input-field first-wrap">
                            <select class="input-field" name="filter" id="filter">
                                <option value="Book_Title">Book Title</option>
                                <option value="Author_Name">Author Name</option>
                                <option value="Price">Price</option>
                                <option value="Type">Type</option>
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
                    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Library /</span> Book store</h4>
                    <form method="get" action="addBook.jsp">
                        <button class="btn btn-primary d-grid" type="submit">Add</button>
                    </form>
                    <br>
                    <!-- Basic Bootstrap Table -->
                    <div class="card">
                        <h5 class="card-header">Table Basic</h5>
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
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody class="table-border-bottom-0">
                                <% ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("books");
                                    if (books != null) {
                                        for (Book book : books) { %>
                                <tr>
                                    <td><%= book.getId() %>
                                    </td>
                                    <td><%= book.getTitle() %>
                                    </td>
                                    <td><%= book.getAuthor() %>
                                    </td>
                                    <td><%= book.getPublicationDate() %>
                                    </td>
                                    <td><%= book.getVersion() %>
                                    </td>
                                    <td><%= book.getGenre() %>
                                    </td>
                                    <td><%= book.getPrice() %>
                                    </td>
                                    <td><%= book.getType() %>
                                    </td>
                                    <td>
                                        <form method="post" action="bookServlet1">
                                            <input type="hidden" name="id" value="<%= book.getId() %>">
                                            <button class="btn btn-primary d-grid" type="submit" name="action"
                                                    value="remove"
                                                    onclick="return confirm('Are you sure you want to delete this book?')">
                                                Delete
                                            </button>
                                        </form>
                                        <form method="get" action="UpdateBook.jsp">
                                            <input type="hidden" name="id" value="<%= book.getId() %>">
                                            <button class="btn btn-primary d-grid" type="submit">Update</button>
                                        </form>
                                    </td>
                                </tr>
                                <% }
                                } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--/ Basic Bootstrap Table -->


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


<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>


<script src="assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="assets/js/main.js"></script>

<!-- Page JS -->

<script>
    window.addEventListener('load', function () {
        var form = document.createElement('form');
        form.method = 'post';
        form.action = 'bookServlet1';
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'action';
        input.value = 'view';
        form.appendChild(input);
        document.body.appendChild(form);

        var libraryMenuItem = document.getElementById('libraryMenuItem');
        libraryMenuItem.addEventListener('click', function (event) {
            event.preventDefault();
            form.submit();
        });

        if (!sessionStorage.getItem('formSubmitted')) {
            libraryMenuItem.click();
            sessionStorage.setItem('formSubmitted', 'true');
        }
    });
</script>

<script>


    // Add event listener to add book button
    const addBookButton = document.getElementById("add-book-button");
    addBookButton.addEventListener("click", () => {
        const popupWindow = window.open("addBook.jsp", "Add Book", "width=500,height=500");

        // Add event listener to form submit button
        const submitButton = popupWindow.document.getElementById("submit-book-button");
        submitButton.addEventListener("click", async (event) => {
            event.preventDefault();

            // Get form data
            const form = popupWindow.document.getElementById("add-book-form");
            const formData = new FormData(form);

            try {
                // Send asynchronous request to add new book
                const response = await fetch("bookServlet1", {
                    method: "POST",
                    body: formData,
                });

                if (response.ok) {
                    // Display success message, close popup window, and redirect to BookList.jsp with view action
                    alert("New book added successfully.");
                    popupWindow.close();
                    const url = "BookList.jsp1?action=view";
                    window.location.href = url + "&" + encodeURIComponent(formData.toString());
                } else {
                    throw new Error("Failed to add new book.");
                }
            } catch (error) {
                console.error(error);
                alert(error.message);
            }
        });
    });

</script>

</body>
</html>




