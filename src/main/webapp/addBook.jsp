<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Book</title>
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

<div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
            <!-- Register -->
            <div class="card">
                <div class="card-body">
                    <!-- Logo -->
                    <div class="app-brand justify-content-center">
                        <a href="index.html" class="app-brand-link gap-2">

                            <span class="app-brand-text demo text-body fw-bolder">Add new book</span>
                        </a>
                    </div>
                    <form id="add-book-form" action="bookServlet1" method="post">
                        <div class="mb-3">
                            <label for="id">ID:</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="id"
                                    name="id" required
                                    placeholder="Book ID"
                                    autofocus
                            >
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="title">Book Title:</label>

                            <input
                                    type="text"
                                    id="title"
                                    name="title" required
                                    class="form-control"
                            >

                        </div>


                        <div class="mb-3">
                            <label for="author">Author Name:</label>
                            <input
                                    type="text"
                                    id="author"
                                    name="name" required
                                    class="form-control">
                        </div>

                        <div class="mb-3">
                            <label for="publication-date">Publication Date:</label>
                            <input
                                    type="date"
                                    id="publication-date"
                                    name="publicationDate" required
                                    class="form-control">
                        </div>

                        <div class="mb-3">
                            <label for="version">Version:</label>
                            <input
                                    type="text"
                                    id="version"
                                    name="version" required
                                    class="form-control">
                        </div>

                        <div class="mb-3">
                            <label for="genre">Genre:</label>
                            <input
                                    type="text"
                                    id="genre"
                                    name="genre" required
                                    class="form-control"></div>

                        <div class="mb-3">
                            <label for="price">Price:</label>
                            <input
                                    type="number"
                                    id="price"
                                    name="price" required
                                    class="form-control">
                        </div>

                        <div class="mb-3">
                            <label for="type">Type:</label>
                            <input
                                    type="text"
                                    id="type"
                                    name="type" required
                                    class="form-control">
                        </div>

                        <div class="mb-3">
                            <button class="btn btn-primary d-grid w-100" type="submit" name="action" value="add">Add
                                Book
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

