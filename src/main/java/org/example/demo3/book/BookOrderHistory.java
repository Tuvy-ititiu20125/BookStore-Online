package org.example.demo3.book;

import java.util.Date;

public class BookOrderHistory {
    private String historyId;
    private String orderId;
    private String bookId;
    private  String action;
    private Date timeStamp;

    public BookOrderHistory(String historyId, String orderId, String bookId, String action, Date timeStamp) {
        this.historyId = historyId;
        this.orderId = orderId;
        this.bookId = bookId;
        this.action = action;
        this.timeStamp = timeStamp;
    }

    public String getHistoryId() {
        return historyId;
    }

    public void setHistoryId(String historyId) {
        this.historyId = historyId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Date getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(Date timeStamp) {
        this.timeStamp = timeStamp;
    }
}