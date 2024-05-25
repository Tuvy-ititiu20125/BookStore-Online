package org.example.demo3.customer;

import java.util.Date;

public class Customer {
    private String ID;
    private String Password;
    private String FirstName;
    private String LastName;
    private Date DOB;
    private double AmountInAccount;

    public Customer(String ID, String password, String firstName, String lastName, Date DOB, double amountInAccount) {
        this.ID = ID;
        Password = password;
        FirstName = firstName;
        LastName = lastName;
        this.DOB = DOB;
        AmountInAccount = amountInAccount;
    }

    public Customer() {

    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String firstName) {
        FirstName = firstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String lastName) {
        LastName = lastName;
    }

    public Date getDOB() {
        return DOB;
    }

    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }

    public double getAmountInAccount() {
        return AmountInAccount;
    }

    public void setAmountInAccount(double amountInAccount) {
        AmountInAccount = amountInAccount;
    }
}
