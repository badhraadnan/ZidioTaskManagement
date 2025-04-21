
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
<body class="bg-light ">
	
	<%
	LocalTime currtime=LocalTime.now();
	String formatedTime=currtime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
	%>
	
<%@ include file="header.jsp" %>

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