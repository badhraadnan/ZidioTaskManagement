package com.TaskManagement.Controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;

@WebServlet("/pages/saveTask")
public class AddTaskController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    String title = request.getParameter("title");
	    String tasktime = request.getParameter("time");	    
	    String taskDate = request.getParameter("date");
	    String endDate = request.getParameter("end_date");
	    String userId = request.getParameter("uid");
	    String status = request.getParameter("status");
	    String priority = request.getParameter("priority");

	    DAOService service = new DAOServiceImpl();
	    service.DBconnect();

	    int result = service.savetask(title, tasktime, taskDate, endDate, userId, status,priority);

	    // Fetch expired tasks
	    

	    if (result > 0) {
            // ✅ Redirect to success page with success message
            response.sendRedirect("success.jsp?success=1");
            
        } else {
            // ❌ Redirect to success page with error message
            response.sendRedirect("success.jsp?success=0");
        }
//	    RequestDispatcher rd = request.getRequestDispatcher("addTask.jsp");
//	    rd.forward(request, response);
	}


}


