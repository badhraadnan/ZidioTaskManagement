<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.HttpSession"%>
<%

int userId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management</title>

<!-- Bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<!-- FontAwesome CDN -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

<!-- Custom Stylesheet -->
<link rel="stylesheet" href="Task_Style.css">

</head>
<body class="bg-light ">

	<%
	LocalTime currtime = LocalTime.now();
	String formatedTime = currtime.format(DateTimeFormatter.ofPattern("HH:mm"));
	%>

<%@ include file="header.jsp" %>


			<!-- Main Content (col-md-9) -->
			<main class="col-md-10 p-4 bg-light">

				<div style="margin-top: 30px;">
					<div style="display: flex; align-items: center; justify-content: center;">
						<form action="saveTask" method="post">
							<h1 class="text-center text-danger text-decoration-underline mb-5">
								<span class="text-primary">A</span><span class="text-info fw-bold">d</span>
								<span class="text-secondary fw-bold">d</span> <span class="text-danger fw-bold">T</span>
								<span class="text-warning fw-bold">a</span><span class="text-success fw-bold">s</span>
								<span class="text-primary fw-bold">k</span>
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
						</form>
					</div>
				</div>

				<%@ include file="dashboard.jsp"%>
			</main>
		

	<%@ include file="../HTML/footer.html"%>
</body>
</html>
