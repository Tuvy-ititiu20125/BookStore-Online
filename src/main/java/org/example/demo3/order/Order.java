package org.example.demo3.order;

import org.example.demo3.book.Book;

import java.util.List;

public class Order {
    private String orderID;
    private String customerID;
    private List<Book> books;
    public Order(String orderId, String customerId, List<Book> books) {
        this.orderID = orderId;
        this.customerID = customerId;
        this.books = books;
    }

    public Order(String orderID, List<Book> books) {
        this.orderID = orderID;
        this.books = books;
    }

    public Order(List<Book> books) {
        this.books = books;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }
}
