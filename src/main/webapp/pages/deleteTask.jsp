<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*" %>
<%
    int tid = Integer.parseInt(request.getParameter("tid"));

    Connection cn = null;
    PreparedStatement ps = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
        ps = cn.prepareStatement("DELETE FROM task WHERE tid = ?");
        ps.setInt(1, tid);
        int rows = ps.executeUpdate();
        
        if (rows > 0) {
            response.sendRedirect("getdetails.jsp");
        } else {
            out.println("Error: Task not deleted.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (cn != null) cn.close();
    }
%>
	
</body>
</html>