package com.TaskManagement.Controller;

import java.io.IOException;

import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;

/**
 * Servlet implementation class TaskDetailsController
 */
@WebServlet("/viewTask")
public class TaskDetailsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    DAOService service = new DAOServiceImpl();
	    service.DBconnect();  // Ensure connection is established
	    ResultSet result = service.getDetails();  

        request.setAttribute("result", result);  // Send ResultSet to JSP
        
        RequestDispatcher rd = request.getRequestDispatcher("admin/viewTask.jsp");
        rd.forward(request, response);
    }
}
