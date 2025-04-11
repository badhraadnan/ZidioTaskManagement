
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

<!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX+3pBnMFcV7oQPJkl9QevSCWr3W6A==" 
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <link rel="stylesheet" href="Task_Style.css">
     
</head>
<body class="bg-light " style="padding-top: 56px;">
	
	<%
	LocalTime currtime=LocalTime.now();
	String formatedTime=currtime.format(DateTimeFormatter.ofPattern("HH:mm"));
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
                    <a class="nav-link active text-white fs-5" href="addTask.jsp">➕ Add Task</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fs-5" href="getdetails.jsp">📋 Pending Tasks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fs-5" href="completeTask.jsp">✅ Completed Tasks</a>
                </li>
                
            </ul>
        </nav>

        <!-- Main Content (col-md-9) -->
        <main class="col-md-9 p-4 bg-light">
            
            
            
       <div style="margin-top: 30px;">
    <div style="display: flex; align-items: center; justify-content: center;">
        <form action="saveTask" method="post">
            <h1 class="text-center text-danger text-decoration-underline mb-5">
                <span class="text-primary">A</span><span class="text-info fw-bold">d</span><span class="text-secondary fw-bold">d</span>
                <span class="text-danger fw-bold">T</span><span class="text-warning fw-bold">a</span><span class="text-success fw-bold">s</span><span class="text-primary fw-bold">k</span>
            </h1>

            <input type="text" name="title" placeholder="Enter Title.." required>
            <input type="hidden" value="<%= formatedTime %>" name="time">
            <input type="hidden" value="<%= LocalDate.now() %>" name="date">

            
<div class="d-flex justify-content-center align-items-center mb-4">
    <div class="me-5">
        <label class="form-label fs-5">Task Due-Date:</label><br>
        <input type="date" class="form-control border-primary" name="end_date" required style="min-width: 200px;">
    </div>
    <div class="ms-3">
        <label class="form-label fs-5">Priority:</label><br>
        <select class="form-select border-primary" name="priority" required style="min-width: 200px;">
            <option value="Low">-- Select Priority --</option>
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
        </select>
    </div>
</div>


            <input type="hidden" name="uid" value="<%= (userId != -1) ? userId : "" %>">
            <input type="hidden" name="status" value="InProgress">

            <input type="submit" class="btn btn-success" value="Add">

            <input type="hidden" value="<%
                if(request.getAttribute("error") != null){
                    out.println(request.getAttribute("error"));
                } else {
                    out.println(request.getAttribute("success"));
                }
            %>">
        </form>
    </div>
</div>
  
        </main>
    </div>
</div>
  <%@ include file="../HTML/footer.html" %>
  
  

	
	
</body>
</html>