<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Task</title>
</head>
<body>

<%
    int tid = Integer.parseInt(request.getParameter("tid"));

    Connection cn = null;
    PreparedStatement ps = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");

        // Corrected SQL query using prepared statement
        ps = cn.prepareStatement("UPDATE task SET status = ? WHERE tid = ?");
        ps.setString(1, "complete");  // Set status to "complete"
        ps.setInt(2, tid);  // Set tid for WHERE condition
        
        int rows = ps.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("getdetails.jsp");
        } else {
            out.println("Error: Task not updated.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
