<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
html, body {
	height: 100%;
}
body {
	display: flex;
	flex-direction: column;
}
main {
	flex: 1;
}

/* your existing styles */
.sidebar {
	background: linear-gradient(to bottom, #007bff, #0056b3);
	color: white;
	padding-top: 20px;
	height: 100vh;
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
.task-card {
	border-radius: 15px;
	transition: transform 0.2s ease-in-out, box-shadow 0.2s;
}
.task-card:hover {
	transform: translateY(-5px);
	box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
}
.badge-pending { background-color: #ffc107; color: black; }
.badge-completed { background-color: #28a745; }
.badge-inprogress { background-color: #17a2b8; }
.navbar { background: #343a40; }
.navbar .navbar-brand { font-size: 24px; font-weight: bold; }
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
				<li class="nav-item"><a class="nav-link text-white">Hello, <%= (userName != null) ? userName : "Guest" %></a></li>
				<li class="nav-item"><a class="nav-link text-white" href="#contact">Contact</a></li>
				<li class="nav-item"><a class="nav-link text-danger" href="../admin/logout.jsp">Logout</a></li>
			</ul>
		</div>
	</div>
</nav>

<div class="container-fluid">
	<div class="row">
		<!-- Sidebar -->
		<nav class="col-md-2 sidebar d-flex flex-column align-items-start">
			<ul class="nav flex-column w-100">
				<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/viewTask.jsp"><i class="fa-solid fa-list-check me-2"></i> View Task</a></li>
				<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/admin/viewProject.jsp"><i class="fa-solid fa-list-check me-2"></i> View Project</a></li>
				<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/user.jsp"><i class="fa-solid fa-people-roof me-2"></i> Manage Users</a></li>
			</ul>
		</nav>