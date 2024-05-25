package org.example.demo3.admin;

import org.example.demo3.connection.ConnectionDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private final ConnectionDB connectionDB;

    public AdminDAO(ConnectionDB connectionDB) {
        this.connectionDB = connectionDB;
    }

    public boolean addAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO admin (ID, Password,FullName, DOB) VALUES ( ?, ?, ?, ?)";

        connectionDB.connect();

        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);

        statement.setString(1, admin.getID());
        statement.setString(2, admin.getPassword());
        statement.setString(3, admin.getFullName());
        statement.setDate(4, new Date(admin.getDOB().getTime()));

        boolean rowInserted = statement.executeUpdate() > 0;
        statement.close();
        connectionDB.disconnect();
        return rowInserted;
    }

    public List<Admin> listAllAdmins() throws SQLException {
        List<Admin> listAdmins = new ArrayList<>();
        String sql = "SELECT * FROM admin";

        connectionDB.connect();

        Statement statement = connectionDB.getJdbcConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            String id = resultSet.getString("ID");
            String password = resultSet.getString("Password");
            String fullName = resultSet.getString("FullName");
            Date DOB = resultSet.getDate("DOB");

            Admin admin = new Admin(id, password, fullName, DOB);
            listAdmins.add(admin);
        }

        resultSet.close();
        statement.close();
        connectionDB.disconnect();
        return listAdmins;
    }

    public boolean updateAdmin(Admin admin) throws SQLException {
        String sql = "UPDATE admin SET FullName =? , Password = ?, DOB= ?  WHERE ID = ?";
        connectionDB.connect();
        PreparedStatement statement = null;
        boolean rowUpdated = false;

        try {
            statement = connectionDB.getJdbcConnection().prepareStatement(sql);
            statement.setString(1, admin.getFullName());
            statement.setString(2, admin.getPassword());
            statement.setDate(3, new Date(admin.getDOB().getTime()));
            statement.setString(4, admin.getID());
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

    public Admin getAdminById(String id) throws SQLException {
        String sql = "SELECT * FROM admin WHERE ID = ?";

        connectionDB.connect();
        PreparedStatement statement = connectionDB.getJdbcConnection().prepareStatement(sql);
        statement.setString(1, id);
        ResultSet resultSet = statement.executeQuery();

        Admin admin = null;
        if (resultSet.next()) {
            admin = new Admin();
            admin.setID(resultSet.getString("id"));
            admin.setFullName(resultSet.getString("password"));
            admin.setFullName(resultSet.getString("fullname"));
            admin.setDOB(resultSet.getDate("dob"));
        }

        resultSet.close();
        return admin;
    }
}
