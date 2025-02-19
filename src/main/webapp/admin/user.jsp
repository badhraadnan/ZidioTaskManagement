<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- FontAwesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- Custom Styles -->
<style>
    /* Sidebar styling */
    .sidebar {
        background: linear-gradient(to bottom, #007bff, #0056b3);
        color: white;
        
        padding-top: 20px;
    }
    .sidebar .nav-link {
        color: white;
        font-size: 18px;
        padding: 12px 15px;
    }
    .sidebar .nav-link:hover {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 5px;
    }

    /* Task Card */
    .task-card {
        border-radius: 15px;
        transition: transform 0.2s ease-in-out, box-shadow 0.2s;
    }
    .task-card:hover {
        transform: translateY(-5px);
        box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
    }

    /* Status badges */
    .badge-pending { background-color: #ffc107; color: black; }
    .badge-completed { background-color: #28a745; }
    .badge-inprogress { background-color: #17a2b8; }

    /* Navbar */
    .navbar {
        background: #343a40;
    }
    .navbar .navbar-brand {
        font-size: 24px;
        font-weight: bold;
    }
</style>

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <span class="text-danger">Z</span><span class="text-white">i</span><span class="text-primary">d</span><span class="text-white">i</span><span class="text-secondary">o</span>
            <span class="text-danger">T</span><span class="text-warning">a</span><span class="text-success">s</span><span class="text-primary">k</span>
        	<span class="text-danger font-monospace">Man</span><span class="text-white font-monospace">agem</span><span class="text-success font-monospace">ent</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link text-white">Hello, <%= (userName != null) ? userName : "Guest" %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#contact">Contact</a>
                </li>
                
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="../admin/logout.jsp">Logout</a>
                    </li>
                
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar d-flex flex-column align-items-start">
            <ul class="nav flex-column w-100">
             
                <li class="nav-item">
                    <a class="nav-link active" href="viewTask.jsp"><i class="fa-solid fa-list-check me-2"></i> View Task</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="user.jsp"><i class="fa-solid fa-people-roof me-2"></i> Manage Users</a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="col-md-10 p-4">
            <h2 class="text-center text-primary mt-5 mb-5">Task Details</h2>
            <div class="row">
            <table class="table table-bordered table-hover text-center mb-5">
            	<tr class="bg-dark text-white border">
            		<th>Id</th>
            		<th>Name</th>
            		<th>UserName</th>
            		<th>Mobile</th>
            		<th>Email</th>
            		<th>Password</th>
            		<th>Delete</th>
            	</tr>
                <%
                    Connection cn = null;
                    PreparedStatement ps = null;
                    int id=1;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
                        ps = cn.prepareStatement("SELECT * FROM user");
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                        	
                            String name = rs.getString(2);                            
                            String username = rs.getString(3);
                            String mobile = rs.getString(4);
                            String email = rs.getString(5);
                            String password = rs.getString(6);
                            
                %>
                	<tr>
            		<td><%= id++ %></td>
            		<td><%= name %></td>
            		<td><%= username %></td>
            		<td><%= mobile %></td>
            		<td><%= email %></td>
            		<td><%= password %></td>
            		<td><a href="userdelete.jsp?uid=<%=rs.getInt("uid")%>" class="text-danger"><i class="fas fa-trash"></a></td>
            	</tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (cn != null) cn.close();
                        if (ps != null) ps.close();
                        
                    }
                %>
                </table>
            </div>
        </main>
    </div>
</div>
<%@ include file="../HTML/footer.html" %>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
