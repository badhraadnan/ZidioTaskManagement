<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    int userId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Task Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body {
            background: #f8f9fa;
        }
        .sidebar {
            min-height: 100vh;
            background: #007bff;
            padding: 20px;
        }
        .sidebar a {
            color: white;
            font-size: 18px;
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 24px;
        }
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-left: 100px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand text-white" href="#">
        <span class="text-danger fw-bold fst-italic">Z</span><span class="text-white fst-italic">i</span><span class="text-primary fw-light fst-italic">d</span><span class="text-white fst-italic">i</span><span class="text-secondary fst-italic">o</span>
        <span class="text-danger fw-bold">T</span><span class="text-warning fw-bold">a</span><span class="text-success fw-bold">s</span><span class="text-primary fw-bold">k</span>
        <span class="text-danger font-monospace">Man</span><span class="text-white font-monospace">agem</span><span class="text-success font-monospace">ent</span>
        
        </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-white" href="#">Hello, <%= userName != null ? userName : "Guest" %></a></li>
                    <% if (userName != null) { %>
                        <li class="nav-item"><a class="nav-link text-danger" href="../logout.jsp">Logout</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 sidebar d-flex flex-column">
                <a href="addTask.jsp" class="nav-link mb-3 fs-5" >➕ Add Task</a>
                <a href="getdetails.jsp" class="nav-link mb-3 fs-5">📋 Pending Tasks</a>
                <a href="completeTask.jsp" class="nav-link mb-3 fs-5">✅ Completed Tasks</a>
                
            </nav>
            <main class="col-md-9 p-4">
    <div class="table-container mt-3">
        <h2 class="text-center text-primary mb-4">Completed Tasks by Priority</h2>

        <% String[] priorities = {"High", "Medium", "Low"};
           String[] colors = {"danger", "warning", "success"}; // Bootstrap colors
           for (int i = 0; i < priorities.length; i++) {
                Connection cn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
                    ps = cn.prepareStatement("SELECT tid, title, status FROM task WHERE uid = ? AND status = ? AND priority = ?");
                    ps.setInt(1, userId);
                    ps.setString(2, "Complete");
                    ps.setString(3, priorities[i]);
                    rs = ps.executeQuery();
        %>
        <div class="card border-<%= colors[i] %> mb-4 shadow-sm">
            <div class="card-header bg-<%= colors[i] %> text-white fs-5">
                <i class="fas fa-flag"></i> <%= priorities[i] %> Priority Tasks
            </div>
            <div class="card-body p-0">
                <table class="table table-striped mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Id</th>
                            <th>Title</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int count = 1;
                           boolean hasData = false;
                           while (rs.next()) {
                               hasData = true;
                        %>
                        <tr>
                            <td><%= count++ %></td>
                            <td><%= rs.getString("title") %></td>
                            <td><%= rs.getString("status") %></td>
                        </tr>
                        <% } 
                           if (!hasData) { %>
                        <tr>
                            <td colspan="3" class="text-center text-muted">No completed tasks in this category.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% 
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (cn != null) cn.close();
                }
           } 
        %>
    </div>
</main>

            
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <%@ include file="../HTML/footer.html" %>
</body>
</html>
