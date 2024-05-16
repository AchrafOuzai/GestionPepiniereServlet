package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.AdminDAO;
import model.Admin;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();
        boolean isValid = adminDAO.validateAdmin(username, password);

        if (isValid) {
            Admin user = new Admin();
            user.setUsername(username);
            request.setAttribute("user", user);

            // Retrieve statistics
            int totalPlants = adminDAO.getTotalPlants();
            int totalProducts = adminDAO.getTotalProducts();
            request.setAttribute("totalPlants", totalPlants);
            request.setAttribute("totalProducts", totalProducts);

            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}



