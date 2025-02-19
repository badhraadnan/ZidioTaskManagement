package com.TaskManagement.Controller;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TaskManagement.Model.DAOService;
import com.TaskManagement.Model.DAOServiceImpl;



//@WebServlet("/process")
//public class RegisterController extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    
//	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String name=request.getParameter("name");
//		String email=request.getParameter("email");
//		String password=request.getParameter("password");
//		
//		DAOService service=new DAOServiceImpl();
//		service.DBconnect();
//		service.verify(name, email, password);
//		
//	}
//
//}


@WebServlet("/pages/process")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username"); // Capture username
        String mobile = request.getParameter("mobile"); // Capture mobile number
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        DAOService service = new DAOServiceImpl();
        service.DBconnect();
        
        int result = service.verify(name, username, mobile, email, password); // Pass all required values

        if (result > 0) {
            response.sendRedirect("../login.jsp"); // Redirect to login page on success
        } else {
            response.sendRedirect("error.jsp"); // Redirect to error page on failure
        }
    }
}


