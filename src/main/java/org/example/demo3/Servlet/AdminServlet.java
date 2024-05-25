package org.example.demo3.Servlet;

import org.example.demo3.admin.Admin;
import org.example.demo3.admin.AdminDAO;
import org.example.demo3.connection.ConnectionDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = "/adminServlet")
public class AdminServlet extends HttpServlet {
    private AdminDAO adminDAO;

    public void init() {
        ConnectionDB connectionDB = new ConnectionDB();
        adminDAO = new AdminDAO(connectionDB);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/AdminUpdateAccount.jsp");
            return;
        }

        switch (action) {
            case "add":
                addAdmin(request, response);
                break;
            case "update":
                try {
                    try {
                        updateAdmin(request, response);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/AdminUpdateAccount.jsp");
                break;
        }
    }

        private void addAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String id = request.getParameter("id");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullname");
            String dobString = request.getParameter("dob");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dob = null;

            try {
                dob = sdf.parse(dobString);
            } catch (ParseException e) {
                e.printStackTrace();
            }

            Admin admin = new Admin(id, password, fullName, dob);

            try {
                adminDAO.addAdmin(admin);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            List<Admin> admins = null;
            try {
                admins = adminDAO.listAllAdmins();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("admins", admins); // add the list of books to the request
            request.getRequestDispatcher("/AdminUpdateAccount.jsp").forward(request, response);    }
    private void updateAdmin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ParseException, SQLException, ServletException {
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullname");
        String dobString = request.getParameter("dob");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dob = sdf.parse(dobString);

        Admin admin = new Admin(id, password, fullName, dob);

        adminDAO.updateAdmin(admin);

        List<Admin> admins = adminDAO.listAllAdmins();
        request.setAttribute("admins", admins);
        request.getRequestDispatcher("/AdminUpdateAccount.jsp").forward(request, response);    }

}




