package org.example.demo3.order;

import org.example.demo3.book.Book;
import org.example.demo3.book.BookOrderHistory;
import org.example.demo3.connection.ConnectionDB;
import enumClass.BookColummn;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private final ConnectionDB connectionDB;

    public OrderDAO(ConnectionDB connectionDB) {
        this.connectionDB = connectionDB;
    }


    public List<BookOrderHistory> listAllOrders(String customerID) throws SQLException {
        List<BookOrderHistory> listBooks = new ArrayList<>();
        String sql = "SELECT * FROM bookorderhistory";

        connectionDB.connect();

        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        ResultSet resultSet = null;

        while (resultSet.next()) {
            String historyID = resultSet.getString("historyID");
            String orderID = resultSet.getString("orderID");
            String bookID = resultSet.getString("bookID");
            String action = resultSet.getString("action");
            Date timestamp = resultSet.getDate("timestamp");

            BookOrderHistory bookOrder = new BookOrderHistory(historyID, orderID, bookID, action, timestamp);
            listBooks.add(bookOrder);
        }

        resultSet.close();
        statement.close();
        connectionDB.disconnect();
        return listBooks;
    }


    public ArrayList<Book> searchBook(BookColummn filter, String value) throws SQLException {
        if (filter == null) {
            throw new IllegalArgumentException("Invalid filter parameter");
        }

        ResultSet rs = null;
        String sql = "SELECT * FROM book WHERE " + filter.toString() + " LIKE ?";
        ArrayList<Book> books = new ArrayList<>();

        try {
            connectionDB.connect();
            PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
            statement.setString(1, "%" + value + "%");
            rs = statement.executeQuery();
            while (rs.next()) {
                Book book = new Book(rs.getString("ID"),
                        rs.getString("BookTitle"),
                        rs.getString("AuthorName"),
                        rs.getDate("PublicationDate"),
                        rs.getInt("Version"),
                        rs.getString("Genre"),
                        rs.getDouble("Price"),
                        rs.getInt("Type"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return books;
    }


    public String createOrder(String customerId) throws SQLException {
        String orderId = generateId("orders");
        String sql = "INSERT INTO orders(ID, customerID) VALUES (?, ?)";
        try (PreparedStatement stmt = connectionDB.getJdbcConnection().prepareStatement(sql)) {
            stmt.setString(1, orderId);
            stmt.setString(2, customerId);
            stmt.executeUpdate();
        }
        return orderId;
    }

    public boolean addBookToOrder(String orderId, String bookId) throws SQLException {
        connectionDB.connect();

        String sql = "INSERT INTO bookorder(orderID, bookID) VALUES (?, ?)";
        PreparedStatement stmt = connectionDB.getJdbcConnection().prepareStatement(sql);
            stmt.setString(1, orderId);
            stmt.setString(2, bookId);
        boolean rowInserted = stmt.executeUpdate() > 0;
        stmt.close();
        connectionDB.disconnect();
        return rowInserted;
    }


    public List<Book> getBooksInOrder(String customerId) throws SQLException {
        ResultSet resultSet = null;
        String sql = "SELECT b.ID, b.BookTitle, b.AuthorName, b.PublicationDate, b.Version, b.Genre, b.Price, b.Type " +
                "FROM customer c " +
                "JOIN orders o ON c.ID = o.customerID " +
                "JOIN bookOrder bo ON o.ID = bo.orderID " +
                "JOIN book b ON bo.bookID = b.ID " +
                "WHERE c.ID = ?";
        List<Book> books = new ArrayList<>();


        connectionDB.connect();

                PreparedStatement stmt = connectionDB.getJdbcConnection().prepareStatement(sql);
            stmt.setString(1, customerId);
            resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                String id = resultSet.getString("ID");
                String title = resultSet.getString("BookTitle");
                String author = resultSet.getString("AuthorName");
                Date publicationDate = resultSet.getDate("PublicationDate");
                int version = resultSet.getInt("Version");
                String genre = resultSet.getString("Genre");
                double price = resultSet.getDouble("Price");
                int type = resultSet.getInt("Type");

                Book book = new Book(id, title, author, publicationDate, version, genre, price, type);

                books.add(book);
            }

        return books;
    }


    private String generateId(String table) throws SQLException {
        String sql = "SELECT MAX(ID) FROM " + table;
        try (PreparedStatement stmt = connectionDB.getJdbcConnection().prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String maxId = rs.getString(1);
                if (maxId == null) {
                    return "O1";
                } else {
// Extract the numeric part from the maxId by removing the "O" prefix
                    int numericPart = Integer.parseInt(maxId.substring(1));
// Increment the numeric part
                    numericPart++;
// Concatenate the "O" prefix with the incremented numeric part
                    return "O" + numericPart;
                }
            } else {
                throw new SQLException("Unable to generate ID.");
            }
        }
    }



}
