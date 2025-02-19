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

@WebServlet("/adminverify")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		DAOService service=new DAOServiceImpl();
		service.DBconnect();
		boolean result = service.adminlogin(username, password);
		
		if (result) {
			// Store email in session
			request.getSession().setAttribute("userName", username);
			RequestDispatcher rd = request.getRequestDispatcher("admin/index.jsp");
			rd.forward(request, response);
		} else {
			request.setAttribute("error", "Invalid Username/Password...");
			RequestDispatcher rd = request.getRequestDispatcher("adminlogin.jsp");
			rd.forward(request, response);
		}
	
	}

	
}
