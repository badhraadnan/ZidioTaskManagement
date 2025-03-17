
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String userName = (String) session.getAttribute("userName");
	int userId = (Integer)session.getAttribute("userId");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .message-container {
            max-width: 500px;
            margin: 100px auto;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #c3e6cb;
            font-size: 18px;
            font-weight: bold;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #f5c6cb;
            font-size: 18px;
            font-weight: bold;
        }
        .btn-container {
            margin-top: 20px;
        }
    </style>
</head>
<body class="bg-light " style="padding-top: 56px;">
	
	<%
	LocalTime currtime=LocalTime.now();
	String formatedTime=currtime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
	%>
	
<nav class="navbar navbar-expand-lg navbar-light bg-dark fixed-top">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand text-white" href="#">
        <span class="text-danger fw-bold fst-italic">Z</span><span class="text-white fst-italic">i</span><span class="text-primary fw-light fst-italic">d</span><span class="text-white fst-italic">i</span><span class="text-secondary fst-italic">o</span>
        <span class="text-danger fw-bold">T</span><span class="text-warning fw-bold">a</span><span class="text-success fw-bold">s</span><span class="text-primary fw-bold">k</span>
        <span class="text-danger font-monospace">Man</span><span class="text-white font-monospace">agem</span><span class="text-success font-monospace">ent</span>
        
        </a>

        <!-- Toggler for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                
                <li class="nav-item">
                    <a class="nav-link text-white" href="#">Hello, <%= (userName != null) ? userName : "Guest" %></a>
                </li>
               
                <% if (userName != null) { %>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="../logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Left Sidebar (col-md-3) -->
        <nav class="col-md-2 bg-primary vh-100 p-3">
          
            <ul class="nav flex-column">
          
                <li class="nav-item">
                    <a class="nav-link active text-white" href="addTask.jsp">➕ Add Task</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="getdetails.jsp">📋 Pending Tasks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="completeTask.jsp">✅ Completed Tasks</a>
                </li>
                
            </ul>
        </nav>

        <!-- Main Content (col-md-9) -->
        <main class="col-md-9 p-4 bg-light">
            
            
       <div class="message-container bg-white">
        <!-- Success Message -->
        <div id="successMsg" class="success-message" style="display: none;">
            <i class="fas fa-check-circle"></i> Task Added Successfully!
        </div>

        <!-- Error Message -->
        <div id="errorMsg" class="error-message" style="display: none;">
            <i class="fas fa-times-circle"></i> Something went wrong. Please try again!
        </div>

        <div class="btn-container">
            <a href="../pages/addTask.jsp" class="btn btn-primary">➕ Add Another Task</a>
            <a href="../pages/getdetails.jsp" class="btn btn-success">📋 View Tasks</a>
        </div>
    </div>

    <script>
        // Get query parameter from URL
        const urlParams = new URLSearchParams(window.location.search);
        const result = urlParams.get('success');

        if (result === '1') {
            document.getElementById("successMsg").style.display = "block";
        } else {
            document.getElementById("errorMsg").style.display = "block";
        }
    </script>     
          
        </main>
    </div>
</div>
  <%@ include file="../HTML/footer.html" %>
  
  

	
	
</body>
</html>