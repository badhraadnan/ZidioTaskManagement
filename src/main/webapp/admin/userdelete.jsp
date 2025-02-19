<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	int uid=Integer.parseInt(request.getParameter("uid"));
	
	
	Connection cn;
	PreparedStatement st;
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp","root","Adnan");
	
	try{
		st=cn.prepareStatement("Delete from user where uid=?");
		st.setInt(1, uid);
		
		int row=st.executeUpdate();
		
		if(row>0){
			out.print("User Deleted....");
			response.sendRedirect("user.jsp");
		}else{
			out.print("User Not Deleted....");
			response.sendRedirect("user.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
		
	}
	%>
</body>
</html>