package org.example.demo3.Servlet;

import org.example.demo3.connection.ConnectionDB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "LoginServlet", urlPatterns = {"/loginServlet"})
public class AdminLoginServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminLoginServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the username and password from the request parameters
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        LOGGER.log(Level.INFO, "ID: {0}", id); // log the ID
        LOGGER.log(Level.INFO, "Password: {0}", password); // log the password

        System.out.println("ID: " + id); // print the ID
        System.out.println("Password: " + password); // print the password

        // Validate the username and password against a database or other data source
        boolean isAuthenticated = authenticateUser(id, password);

        LOGGER.log(Level.INFO, "Is authenticated: {0}", isAuthenticated); // log whether the user is authenticated

        System.out.println("Is authenticated: " + isAuthenticated); // print whether the user is authenticated

        // If the user is authenticated, redirect to the AdminPage.jsp
        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("adminId", id);
            response.sendRedirect(request.getContextPath() + "/AdminManagePage.jsp");        }
        // If the user is not authenticated, set an error message
        else {
            request.setAttribute("errorMessage", "Invalid username or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/AdminLogin.jsp");
            dispatcher.forward(request, response);
        }
    }

    private boolean authenticateUser(String id, String password) {
        boolean isAuthenticated = false;
        ConnectionDB connectionDB = new ConnectionDB();
        try {
            // Connect to the database
            connectionDB.connect();

            // Prepare a statement to execute the SQL query
            String sql = "SELECT * FROM admin WHERE ID = ? AND Password = ?";
            PreparedStatement stmt = connectionDB.getJdbcConnection().prepareStatement(sql);
            stmt.setString(1, id);
            stmt.setString(2, password);

            LOGGER.log(Level.INFO, "SQL query: {0}", stmt.toString()); // log the SQL query

            System.out.println("SQL query: " + stmt); // print the SQL query

            // Execute the query and check if the result set has a row
            ResultSet rs = stmt.executeQuery();
            isAuthenticated = rs.next();

            // Close the database resources
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error authenticating user", e); // log any exceptions
        } finally {
            // Disconnect from the database
            try {
                connectionDB.disconnect();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error disconnecting from database", e);
            }
        }
        return isAuthenticated;
    }
}