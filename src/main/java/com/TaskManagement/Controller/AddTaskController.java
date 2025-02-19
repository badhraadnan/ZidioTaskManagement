package com.TaskManagement.Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;

@WebServlet("/pages/saveTask")
public class AddTaskController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title=request.getParameter("title");
		String tasktime=request.getParameter("time");
		String taskDate=request.getParameter("date");
		String userId=request.getParameter("uid");
		String status=request.getParameter("status");
		
		DAOService service=new DAOServiceImpl();
		
		service.DBconnect();
		int result = service.savetask(title, tasktime, taskDate, userId,status);
		
		if(result>0) {
			request.setAttribute("success", "Task Added Successfully...");
			RequestDispatcher rd=request.getRequestDispatcher("addTask.jsp");
			rd.forward(request, response);
		}else {
			request.setAttribute("error", "Something Wrong...");
			RequestDispatcher rd=request.getRequestDispatcher("addTask.jsp");
			rd.forward(request, response);
		}
		
	}
}
