<%@ page import="java.sql.*" %>
<%
    Connection cn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
        // Store connection in request scope to be used in the current JSP
        request.setAttribute("dbcon", cn);
    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
