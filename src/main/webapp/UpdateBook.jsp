<%@ page import="org.example.demo3.book.BookDAO" %>
<%@ page import="org.example.demo3.connection.ConnectionDB" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.example.demo3.book.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Book</title>
    <meta charset="utf-8" />


    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet"  type="text/css" href="assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet"  type="text/css" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet"  type="text/css" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet"  type="text/css" href="assets/css/demo.css" />


    <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
    <!-- Helpers -->
    <script src="assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="assets/js/config.js"></script>
</head>
<body>
<%
    // Retrieve the book ID from the request parameter
    String bookId = request.getParameter("id");

    // Retrieve the current book's information from the database using the book ID
    ConnectionDB connectionDB = new ConnectionDB();
    BookDAO bookDAO = new BookDAO(connectionDB);
    Book book;
    try {
        book = bookDAO.getBookById(bookId);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
<div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
            <!-- Register -->
            <div class="card">
                <div class="card-body">
                    <!-- Logo -->
                    <div class="app-brand justify-content-center">
                        <a href="index.html" class="app-brand-link gap-2">

                            <span class="app-brand-text demo text-body fw-bolder">Update Book</span>
                        </a>
                    </div>
                    <form id="add-book-form" action="bookServlet1" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= book.getId() %>">
                        <div class="mb-3">
                            <label for="bookTitle">Title:</label>
                            <input
                                    type="text"
                                    id="bookTitle"
                                    name="bookTitle"
                                    value="<%= book.getTitle() %>"
                            class="form-control">
                        </div>


                            <div class="mb-3">
                                <label for="authorName">Author:</label>
                                <input
                                        type="text"
                                        id="authorName"
                                        name="authorName"
                                        value="<%= book.getAuthor() %>"
                                class="form-control">

                            </div>


                        <div class="mb-3">
                            <label for="publicationDate">Publication Date:</label>
                            <input
                                    type="date"
                                    id="publicationDate"
                                    name="publicationDate"
                                    value="<%= book.getPublicationDate() %>"
                            class="form-control">

                        </div>

                        <div class="mb-3">
                            <label for="version">Version:</label>
                            <input
                                    type="text"
                                    id="version"
                                    name="version"
                                    value="<%= book.getVersion() %>"
                            class="form-control">

                        </div>

                        <div class="mb-3">
                            <label for="genre">Genre:</label>
                            <input
                                    type="text"
                                    id="genre"
                                    name="genre"
                                    value="<%= book.getGenre() %>"
                            class="form-control">

                        </div>

                        <div class="mb-3">
                            <label for="price">Price:</label>
                            <input
                                    type="number"
                                    id="price" name="price"
                                    step="0.01"
                                    min="0"
                                    value="<%= book.getPrice() %>"
                            class="form-control">
                        </div>

                        <div class="mb-3">
                            <label for="type">Type:</label>
                            <input
                                    type="text"
                                    id="type"
                                    name="type"
                                    value="<%= book.getType() %>"
                            class="form-control">

                        </div>
                        <div class="mb-3">
                            <button  class="btn btn-primary d-grid w-100" type="submit">Update Book</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>