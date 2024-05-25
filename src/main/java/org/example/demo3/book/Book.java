package org.example.demo3.book;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class Book {
    private String ID;
    private String BookTitle;
    private String AuthorName;
    private Date PublicationDate;
    private int Version;
    private String Genre;
    private double Price;
    private int Type;

    public Book(String id, String title, String author, Date publicationDate, int version, String genre, double price, int type) {
        this.ID = id;
        this.BookTitle = title;
        this.AuthorName = author;
        this.PublicationDate = publicationDate;
        this.Version = version;
        this.Genre = genre;
        this.Price = price;
        this.Type = type;
    }

    public Book(String id) {
        this.ID = id;
    }

    public Book() {

    }

    public String getId() {
        return ID;
    }

    public void setId(String ID) {
        this.ID = ID;
    }

    public String getTitle() {
        return BookTitle;
    }

    public void Title(String bookTitle) {
        BookTitle = bookTitle;
    }

    public String getAuthor() {
        return AuthorName;
    }

    public void setAuthor(String authorName) {
        AuthorName = authorName;
    }

    public Date getPublicationDate() {
        return PublicationDate;
    }

    public void setPublicationDate(Date publicationDate) {
        PublicationDate = publicationDate;
    }

    public int getVersion() {
        return Version;
    }

    public void setVersion(int version) {
        Version = version;
    }

    public String getGenre() {
        return Genre;
    }

    public void setGenre(String genre) {
        Genre = genre;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double price) {
        Price = price;
    }

    public int getType() {
        return Type;
    }

    public void setType(int type) {
        Type = type;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }


    public String getBookTitle() {
        return BookTitle;
    }

    public void setBookTitle(String bookTitle) {
        BookTitle = bookTitle;
    }

    public String getAuthorName() {
        return AuthorName;
    }

    public void setAuthorName(String authorName) {
        AuthorName = authorName;
    }

    public void setProperties(Map<String, String> properties) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (Map.Entry<String, String> entry : properties.entrySet()) {
            switch (entry.getKey()) {
                case "BookTitle":
                    setBookTitle(entry.getValue());
                    break;
                case "AuthorName":
                    setAuthor(entry.getValue());
                    break;
                case "PublicationDate":
                    setPublicationDate(dateFormat.parse(entry.getValue()));
                    break;
                case "Version":
                    setVersion(Integer.parseInt(entry.getValue()));
                    break;
                case "Genre":
                    setGenre(entry.getValue());
                    break;
                case "Price":
                    setPrice(Double.parseDouble(entry.getValue()));
                    break;
                case "Type":
                    setType(Integer.parseInt(entry.getValue()));
                    break;
                // Add more cases for additional properties
                default:
                    // Ignore unknown properties
                    break;
            }
        }
    }
}