package org.example.demo3.admin;

import java.util.Date;

public class Admin {
    private String ID;
    private String Password;
    private String FullName;
    private Date DOB;

    public Admin(String ID, String password, String fullName, Date DOB) {
        this.ID = ID;
        Password = password;
        FullName = fullName;
        this.DOB = DOB;
    }

    public Admin() {

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

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String fullName) {
        FullName = fullName;
    }

    public Date getDOB() {
        return DOB;
    }

    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "ID='" + ID + '\'' +
                ", Password='" + Password + '\'' +
                ", FullName='" + FullName + '\'' +
                ", DOB=" + DOB +
                '}';
    }
}
