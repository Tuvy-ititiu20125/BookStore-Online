package org.example.demo3.Servlet;

import org.example.demo3.book.Book;
import org.example.demo3.book.BookDAO;
import org.example.demo3.book.BookOrderHistory;
import org.example.demo3.connection.ConnectionDB;
import org.example.demo3.order.OrderDAO;
import com.google.gson.Gson;
import enumClass.BookColummn;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/orderServlet"})
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDao;
    private BookDAO bookDAO;

    public void init() {
        ConnectionDB connectionDB = new ConnectionDB();
        try {
            connectionDB.connect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        orderDao = new OrderDAO(connectionDB);
        bookDAO = new BookDAO(connectionDB);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String customerId = request.getParameter("customerId");
        if (action == null) {
            action = "list";
        }
        try {
            switch (action) {
                case "view":
                    viewBooksInOrder(request, response);
                    break;
                case "search":
                    searchBooks(request, response);
                    break;
                default:
                    listOrders(request, response, customerId);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String customerId = request.getParameter("customerId");
        if (action == null) {
            action = "list";
        }
        try {
            switch (action) {
                case "create":
                    createOrder(request, response, customerId);
                    break;
                case "add":
                    addBookToOrder(request, response);
                    break;
                case "viewBook":
                    viewBooks(request, response);
                    break;
                case "saveOrder":
                    saveOrder(request, response);
                default:
                    listOrders(request, response, customerId);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void saveOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String[] bookIDs = request.getParameterValues("bookIDs");
        String customerID = request.getParameter("customerId");

        // Retrieve the books with the selected IDs from the database using getBookById
        List<Book> books = new ArrayList<>();
        for (String bookId : bookIDs) {
            Book book = bookDAO.getBookById(bookId);
            if (book != null) {
                books.add(book);
            }
        }

        // Add the order to the database
        String orderId = orderDao.createOrder(customerID);

        // Add books to the order
        for (String bookId : bookIDs) {
            orderDao.addBookToOrder(orderId, bookId);
        }

        // Set the generated orderId as a request attribute
        request.setAttribute("orderId", orderId);

        // Forward the request to the viewOrder.jsp page with the orderId attribute
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewOrder.jsp");
        dispatcher.forward(request, response);
    }



    private void viewBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> books = null;

        try {
            books = bookDAO.listAllBooks();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Convert the list of books to JSON
        Gson gson = new Gson();
        String json = gson.toJson(books);

        // Set the JSON as the response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }


    private void listOrders(HttpServletRequest request, HttpServletResponse response, String customerId) throws SQLException, ServletException, IOException {
        List<BookOrderHistory> orderList = orderDao.listAllOrders(customerId);
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("orderList.jsp").forward(request, response);
    }

    private void viewBooksInOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        // Assuming you have an instance of the class containing the getBooksInOrder method
        List<Book> books = orderDao.getBooksInOrder(customerId);

        // Set the list of books as an attribute to the request or session
        request.setAttribute("booksInOrder", books);

        System.out.println(customerId);

        // Send the list of books as a JSON response
        Gson gson = new Gson();
        String json = gson.toJson(books);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }





    private void searchBooks(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String filter = request.getParameter("filter");
        String value = request.getParameter("value");
        BookColummn bookFilter = BookColummn.valueOf(filter.toUpperCase());
        ArrayList<Book> books = orderDao.searchBook(bookFilter, value);
        request.setAttribute("books", books);
        request.getRequestDispatcher("customerBookList.jsp").forward(request, response);
    }

    private void createOrder(HttpServletRequest request, HttpServletResponse response, String customerId) throws SQLException, IOException {
        String orderId = orderDao.createOrder(customerId);
        response.sendRedirect(request.getContextPath() + "/orders?action=view&orderId=" + orderId);
    }

    private void addBookToOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String orderId = request.getParameter("orderId");
        String bookId = request.getParameter("bookId");
        orderDao.addBookToOrder(orderId, bookId);
        response.sendRedirect(request.getContextPath() + "/orders?action=view&orderId=" + orderId);
    }
}