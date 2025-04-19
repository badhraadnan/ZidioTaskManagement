package com.TaskManagement.Controller;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;

/**
 * Servlet implementation class ProjectUpdateController
 */
@WebServlet("/project/saveUpdate")
public class ProjectUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        int projectId = Integer.parseInt(request.getParameter("project_id"));
        String workDone = request.getParameter("work_done").trim();
        int userId =Integer.parseInt( request.getParameter("user_id"));

    

        // Call service to save the update
        DAOService service = new DAOServiceImpl();
        service.DBconnect();
        int result = service.saveProjectUpdates(projectId, userId, workDone);

        if (result > 0) {
            // Redirect back to the project details page after successful update
            response.sendRedirect("updateProject.jsp?projectId=" + projectId);
        } else {
            // Redirect to an error page if saving the update fails
            response.sendRedirect("../pages/error.jsp");
        }
    }
}
