package com.TaskManagement.Controller;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TaskManagement.Model.DAOServiceImpl;
import com.TaskManagement.Model.DAOService;

/**
 * Servlet implementation class ProjectDetailsController
 */
@WebServlet("/projects/details")
public class ProjectDetailsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve 'userName' from the session
        String userName = (String) request.getSession().getAttribute("userName");

        // If no 'userName' in session, redirect to login page
        if (userName == null || userName.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        DAOService service = new DAOServiceImpl();
        service.DBconnect();

        // Fetch project details by 'userName'
        ResultSet rs = service.getProjectDetails(userName);

        // Check if ResultSet is not null and pass it to JSP
        if (rs != null) {
            request.setAttribute("projectDetails", rs);
        } else {
            request.setAttribute("projectDetails", new ResultSet[]{});
        }
        

        // Forward the data to JSP page for rendering
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/projectDetails.jsp");
        dispatcher.forward(request, response);
    }
}
