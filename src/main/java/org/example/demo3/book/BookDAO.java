package org.example.demo3.book;

import org.example.demo3.connection.ConnectionDB;
import enumClass.BookColummn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    private final ConnectionDB connectionDB;

    public BookDAO(ConnectionDB connectionDB) {
        this.connectionDB = connectionDB;
    }



    public boolean addBook(Book book) throws SQLException {
        String sql = "INSERT INTO book (ID, BookTitle, AuthorName, PublicationDate, Version, Genre, Price, Type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        connectionDB.connect();

        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        statement.setString(1, book.getId());
        statement.setString(2, book.getTitle());
        statement.setString(3, book.getAuthor());
        statement.setDate(4, new Date(book.getPublicationDate().getTime()));
        statement.setInt(5, book.getVersion());
        statement.setString(6, book.getGenre());
        statement.setDouble(7, book.getPrice());
        statement.setInt(8, book.getType());

        boolean rowInserted = statement.executeUpdate() > 0;
        statement.close();
        connectionDB.disconnect();
        return rowInserted;
    }

    public List<Book> listAllBooks() throws SQLException {
        List<Book> listBooks = new ArrayList<>();
        String sql = "SELECT * FROM book";

        connectionDB.connect();

        Statement statement = connectionDB.getJdbcConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

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
            listBooks.add(book);
        }

        resultSet.close();
        statement.close();
        connectionDB.disconnect();
        return listBooks;
    }

    public boolean updateBook(Book book) throws SQLException {
        String sql = "UPDATE book SET BookTitle = ? , AuthorName = ?, PublicationDate = ?, Version = ?, Genre = ?, Price = ?, Type = ? WHERE ID = ?";
        connectionDB.connect();
        PreparedStatement statement = null;
        boolean rowUpdated = false;

        try {
            statement = connectionDB.getJdbcConnection().prepareStatement(sql);
            statement.setString(1, book.getBookTitle());
            statement.setString(2, book.getAuthorName());
            statement.setDate(3, new Date(book.getPublicationDate().getTime()));
            statement.setInt(4, book.getVersion());
            statement.setString(5, book.getGenre());
            statement.setDouble(6, book.getPrice());
            statement.setInt(7, book.getType());
            statement.setString(8, book.getId());
            rowUpdated = statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                statement.close();
            }
            connectionDB.disconnect();
        }

        return rowUpdated;
    }

    public boolean deleteBook(String id) throws SQLException {
        String sql = "DELETE FROM book WHERE ID = ?";

        connectionDB.connect();

        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        statement.setString(1, id);

        boolean rowDeleted = statement.executeUpdate() > 0;
        statement.close();
        connectionDB.disconnect();
        return rowDeleted;
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

    public Book getBookById(String id) throws SQLException {
        String sql = "SELECT * FROM book WHERE ID = ?";

        connectionDB.connect();
        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        statement.setString(1, id);
        ResultSet resultSet = statement.executeQuery();

        Book book = null;
        if (resultSet.next()) {
            book = new Book();
            book.setId(resultSet.getString("id"));
            book.setBookTitle(resultSet.getString("bookTitle"));
            book.setAuthorName(resultSet.getString("authorName"));
            book.setPublicationDate(resultSet.getDate("publicationDate"));
            book.setVersion(resultSet.getInt("version"));
            book.setGenre(resultSet.getString("genre"));
            book.setPrice(resultSet.getDouble("price"));
            book.setType(resultSet.getInt("type"));
        }

        resultSet.close();
        return book;
    }

    public int totalNoCustomer() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT ID) AS TotalCustomer FROM Customer";
        connectionDB.connect();
        Statement statement = connectionDB.getJdbcConnection().createStatement();
        ResultSet rs = statement.executeQuery(sql);
        int totalCustomer = 0;
        if(rs.next()){
            totalCustomer = rs.getInt("TotalCustomer");
        }
        rs.close();
        statement.close();
        connectionDB.disconnect();
        return totalCustomer;
    }

    public int totalNoBook() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT ID) AS TotalBooks FROM book";
        connectionDB.connect();
        Statement statement = connectionDB.getJdbcConnection().createStatement();
        ResultSet rs = statement.executeQuery(sql);
        int totalBooks = 0;
        if(rs.next()){
            totalBooks = rs.getInt("TotalBooks");
        }
        rs.close();
        statement.close();
        connectionDB.disconnect();
        return totalBooks;
    }

}
