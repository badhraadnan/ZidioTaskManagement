package com.TaskManagement.Controller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;



@WebServlet("/verify")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        DAOService service = new DAOServiceImpl();
        service.DBconnect();
        int userId = service.logincreditial(username, password);

        if (userId != -1) {
            // Store username and user ID in session
            request.getSession().setAttribute("userName", username);
            request.getSession().setAttribute("userId", userId);
            
            RequestDispatcher rd = request.getRequestDispatcher("pages/home.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("error", "Invalid Username/Password...");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }
}
