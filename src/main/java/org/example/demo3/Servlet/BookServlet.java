package org.example.demo3.Servlet;

import org.example.demo3.book.Book;
import org.example.demo3.book.BookDAO;
import org.example.demo3.connection.ConnectionDB;
import enumClass.BookColummn;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@WebServlet(name = "BookServlet1", urlPatterns = {"/bookServlet1"})
public class BookServlet extends HttpServlet {

    private BookDAO bookDAO;

    public void init() {
        ConnectionDB connectionDB = new ConnectionDB();
        bookDAO = new BookDAO(connectionDB);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/BookList.jsp");
            return;
        }

        switch (action) {
            case "add":
                try {
                    addBook(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "remove":
                removeBook(request, response);
                break;
            case "update":
                try {
                    try {
                        updateBook(request, response);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "search":
                searchBook(request, response);
                break;
            case "view":
                viewAllBooks(request, response);
                break;


            case "countTotalCustomer":
                try {
                    totalCustomer(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "countTotalBooks":
                try {
                    totalBooks(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/BookList.jsp");
                break;
        }
    }


    private void addBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publicationDateString = request.getParameter("publicationDate");
        int version = Integer.parseInt(request.getParameter("version"));
        String genre = request.getParameter("genre");
        String price = request.getParameter("price");
        int type = Integer.parseInt(request.getParameter("type"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date publicationDate = null;

        try {
            publicationDate = sdf.parse(publicationDateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Book book = new Book(id, title, author, publicationDate, version, genre, Double.parseDouble(price), type);

        try {
            bookDAO.addBook(book);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<Book> books = bookDAO.listAllBooks();
        request.setAttribute("books", books); // add the list of books to the request
        request.getRequestDispatcher("/BookList.jsp").forward(request, response);    }

    private void removeBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");


        try {
            bookDAO.deleteBook(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<Book> books = new ArrayList<>();

        try {
            books = bookDAO.listAllBooks();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("books", books);
        request.getRequestDispatcher("/BookList.jsp").forward(request, response);

    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ParseException, SQLException, ServletException {
        String id = request.getParameter("id");
        String bookTitle = request.getParameter("bookTitle");
        String authorName = request.getParameter("authorName");
        String publicationDateString = request.getParameter("publicationDate");
        int version = Integer.parseInt(request.getParameter("version"));
        String genre = request.getParameter("genre");
        double price = Double.parseDouble(request.getParameter("price"));
        int type = Integer.parseInt(request.getParameter("type"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date publicationDate = sdf.parse(publicationDateString);

        Book book = new Book(id, bookTitle, authorName, publicationDate, version, genre, price, type);

        bookDAO.updateBook(book);

        List<Book> books = bookDAO.listAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/BookList.jsp").forward(request, response);    }

    private void searchBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filterParam = request.getParameter("filter");
        String value = request.getParameter("value");

        // Map the filter parameter to a column name using an enum
        BookColummn filter = BookColummn.valueOf(filterParam.toUpperCase());

        ArrayList<Book> books = new ArrayList<>();

        try {
            books = bookDAO.searchBook(filter, value);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("books", books);
        request.getRequestDispatcher("/BookList.jsp").forward(request, response);
        System.out.println("Filter: " + filterParam);
        System.out.println("Value: " + value);
        if (books == null || books.isEmpty()) {
            System.out.println("No books found");
        } else {
            System.out.println("Found " + books.size() + " books");
        }
    }


    private void viewAllBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> books = null;

        try {
            books = bookDAO.listAllBooks();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Set the list of books as a request attribute
        request.setAttribute("books", books);

        // Forward the request to the BookList.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("BookList.jsp");
        dispatcher.forward(request, response);
    }





    private void totalCustomer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int totalCustomer = bookDAO.totalNoCustomer();
        System.out.println("Total Customer: "+ totalCustomer);
        response.setContentType("text/plain");
        response.getWriter().write(Integer.toString(totalCustomer));
    }

    private void totalBooks(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        int totalBooks = bookDAO.totalNoBook();
        System.out.println("Total Customer: "+ totalBooks);
        response.setContentType("text/plain");
        response.getWriter().write(Integer.toString(totalBooks));
    }
}