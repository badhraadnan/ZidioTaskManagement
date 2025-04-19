//package com.TaskManagement.Controller;
//
//import java.io.IOException;
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.TaskManagement.Model.DAOService;
//import com.TaskManagement.Model.DAOServiceImpl;
//
//@WebServlet("/project/saveproject")
//public class AddProjectController extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String title = request.getParameter("title");
//        String description = request.getParameter("description");
//        String deadline = request.getParameter("deadline");
//        int created_by = Integer.parseInt(request.getParameter("created_by"));
//
//      
//
//        DAOService service = new DAOServiceImpl();
//        service.DBconnect();
//
//        int result = service.saveproject(title, description, created_by, deadline);
//
//        if (result > 0) {
//      
//           response.sendRedirect("addproject.jsp?success=1");
//        } else {
//            response.sendRedirect("../pages/error.jsp?success=0");
//        }
//    }
//}
//


package com.TaskManagement.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;

@WebServlet("/project/saveproject")
public class AddProjectController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadline = request.getParameter("deadline");
        String status = request.getParameter("status");
        int created_by = Integer.parseInt(request.getParameter("created_by"));

        String[] memberUsernames = {
            request.getParameter("memberUsername0"),
            request.getParameter("memberUsername1"),
            request.getParameter("memberUsername2")
        };

        String[] memberRoles = {
            request.getParameter("memberRole0"),
            request.getParameter("memberRole1"),
            request.getParameter("memberRole2")
        };

        DAOService service = new DAOServiceImpl();
        service.DBconnect();

        // Save project and retrieve the generated project ID
        int projectId = service.saveproject(title, description, created_by, deadline, status);

        if (projectId > 0) {
            // Add team members to the project_team table
            for (int i = 0; i < 3; i++) {
                service.addTeamMember(projectId, memberUsernames[i], memberRoles[i]);
            }

            response.sendRedirect("addproject.jsp?success=1");
        } else {
            response.sendRedirect("addproject.jsp?success=0");
        }
    }
}


