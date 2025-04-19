<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Database/dbcon.jsp" %>
<%
    String projectId = request.getParameter("projectId");


    if (projectId != null) {
        
        PreparedStatement ps = null;
        try {
            // Setup your database connection
            // Assuming you have a database connection utility
            

           
            // Now delete the project itself from the projects table
            ps = cn.prepareStatement("UPDATE projects set status='Complete' WHERE project_id = ?");
            ps.setInt(1, Integer.parseInt(projectId));
            ps.executeUpdate();

            // Redirect to dashboard after deletion
            response.sendRedirect("projectDetails.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Show error message
            out.println("<script>alert('Error updating project');</script>");
        } finally {
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        }
    }
%>
