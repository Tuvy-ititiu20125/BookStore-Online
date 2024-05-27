package org.example.demo3.customer;

import org.example.demo3.connection.ConnectionDB;
import enumClass.CustomerColumn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private final ConnectionDB connectionDB;

    public CustomerDAO(ConnectionDB connectionDB) {
        this.connectionDB = connectionDB;
    }

    public boolean addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customer (ID, Password, FirstName, LastName, DOB, AmountInAccount) VALUES (?, ?, ?, ?, ?, ?)";

        connectionDB.connect();

        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);

        statement.setString(1, customer.getID());
        statement.setString(2, customer.getPassword());
        statement.setString(3, customer.getFirstName());
        statement.setString(4, customer.getLastName());
        statement.setDate(5, new Date(customer.getDOB().getTime()));
        statement.setDouble(6, customer.getAmountInAccount());

        boolean rowInserted = statement.executeUpdate() > 0;
        statement.close();
        connectionDB.disconnect();
        return rowInserted;
    }

    public List<Customer> listAllCustomers() throws SQLException {
        List<Customer> listCustomers = new ArrayList<>();
        String sql = "SELECT * FROM customer";

        connectionDB.connect();

        Statement statement = connectionDB.getJdbcConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            String id = resultSet.getString("ID");
            String password = resultSet.getString("Password");
            String firstName = resultSet.getString("FirstName");
            String lastName = resultSet.getString("LastName");
            Date DOB = resultSet.getDate("DOB");
            double AmountInAccount = resultSet.getDouble("AmountInAccount");

            Customer customer = new Customer(id, password, firstName, lastName, DOB, AmountInAccount);
            listCustomers.add(customer);
        }

        resultSet.close();
        statement.close();
        connectionDB.disconnect();
        return listCustomers;
    }

    public boolean deleteCustomer(String id) throws SQLException {
        String sql = "DELETE FROM customer WHERE ID = ?";

        connectionDB.connect();

        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        statement.setString(1, id);

        boolean rowDeleted = statement.executeUpdate() > 0;
        statement.close();
        connectionDB.disconnect();
        return rowDeleted;
    }

    public ArrayList<Customer> searchCustomer(CustomerColumn filter, String value) {
        if (filter == null) {
            throw new IllegalArgumentException("Invalid filter parameter");
        }

        ResultSet rs = null;
        String sql = "SELECT * FROM customer WHERE " + filter.toString() + " LIKE ?";
        ArrayList<Customer> customers = new ArrayList<>();

        try {
            connectionDB.connect();
            PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
            statement.setString(1, "%" + value + "%");
            rs = statement.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer(rs.getString("ID"),
                        rs.getString("Password"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getDate("DOB"),
                        rs.getDouble("AmountInAccount"));
                customers.add(customer);
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

        return customers;
    }
    public Customer getCustomerById(String id) throws SQLException {
        String sql = "SELECT * FROM customer WHERE ID = ?";

        connectionDB.connect();
        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        statement.setString(1, id);
        ResultSet resultSet = statement.executeQuery();

        Customer customer = null;
        if (resultSet.next()) {
            customer = new Customer();
            customer.setID(resultSet.getString("ID"));
            customer.setPassword(resultSet.getString("Password"));
            customer.setFirstName(resultSet.getString("FirstName"));
            customer.setLastName(resultSet.getString("Lastname"));
            customer.setDOB(resultSet.getDate("DOB"));
            customer.setAmountInAccount(resultSet.getDouble("AmountInAccount"));
        }

        resultSet.close();
        return customer;
    }

    public void updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customer SET Password = ?, FirstName = ?, LastName = ?, DOB = ?, AmountInAccount = ? WHERE ID = ?";

        connectionDB.connect();
        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);

        statement.setString(1, customer.getPassword());
        statement.setString(2, customer.getFirstName());
        statement.setString(3, customer.getLastName());
        statement.setDate(4, new Date(customer.getDOB().getTime()));
        statement.setDouble(5, customer.getAmountInAccount());
        statement.setString(6, customer.getID());

        statement.executeUpdate();
        statement.close();
        connectionDB.disconnect();
    }

}
