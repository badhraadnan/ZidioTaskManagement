<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%
String userName = (String) session.getAttribute("userName");
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand text-white" href="#"> <span
			class="text-danger fw-bold fst-italic">Z</span> <span
			class="text-white fst-italic">i</span> <span
			class="text-primary fw-light fst-italic">d</span> <span
			class="text-white fst-italic">i</span> <span
			class="text-secondary fst-italic">o</span> <span
			class="text-danger fw-bold">T</span> <span
			class="text-warning fw-bold">a</span> <span
			class="text-success fw-bold">s</span> <span
			class="text-primary fw-bold">k</span> <span
			class="text-danger font-monospace">Man</span> <span
			class="text-white font-monospace">agem</span> <span
			class="text-success font-monospace">ent</span>
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item"><a class="nav-link text-white" href="#">Hello,
						<%=(userName != null) ? userName : "Guest"%></a></li>

				<%
				if (userName != null) {
				%>
				<li class="nav-item"><a class="nav-link text-danger"
					href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>

<!-- Sidebar -->
<div class="container-fluid">
	<div class="row">
		<!-- Sidebar (2 columns) -->
		<!-- Sidebar (update links correctly) -->
		<nav class="col-md-2 bg-primary vh-100 p-0">
			<ul class="nav flex-column pt-3">
				<li class="nav-item"><a
					class="nav-link active text-white fs-5 px-3"
					href="<%=request.getContextPath()%>/pages/addTask.jsp">➕ Add
						Task</a></li>

				<li class="nav-item"><a
					class="nav-link active text-white fs-5 px-3"
					href="<%=request.getContextPath()%>/project/addproject.jsp">➕
						Add Project</a></li>

				<li class="nav-item"><a class="nav-link text-white fs-5 px-3"
					href="<%=request.getContextPath()%>/pages/getdetails.jsp">📋
						Pending Tasks</a></li>
				<li class="nav-item"><a class="nav-link text-white fs-5 px-3"
					href="<%=request.getContextPath()%>/pages/completeTask.jsp">✅
						Completed Tasks</a></li>

			</ul>
		</nav>