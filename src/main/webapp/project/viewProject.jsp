<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../Database/dbcon.jsp"%>

<%
int projectId = Integer.parseInt(request.getParameter("projectId"));
String userName = (String) session.getAttribute("userName");
PreparedStatement st = null;
ResultSet rs = null;

String title = "", description = "", deadline = "", createdBy = "", status = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Update Tracker</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
.timeline {
	position: relative;
	margin: 2rem 0;
	padding-left: 40px;
	border-left: 3px solid #0d6efd;
}

.timeline-entry {
	margin-bottom: 2rem;
	position: relative;
}

.timeline-entry::before {
	content: '';
	position: absolute;
	left: -11px;
	top: 0;
	width: 20px;
	height: 20px;
	background-color: #0d6efd;
	border-radius: 50%;
	border: 3px solid white;
}

.timeline-entry .card {
	margin-left: 15px;
	background-color: #f8f9fa;
}

.card-header {
	background-color: #0d6efd;
	color: white;
	font-weight: bold;
	

}
</style>
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand text-white" href="#">
			<span class="text-danger fw-bold fst-italic">Z</span><span class="text-white fst-italic">i</span>
			<span class="text-primary fw-light fst-italic">d</span><span class="text-white fst-italic">i</span>
			<span class="text-secondary fst-italic">o</span><span class="text-danger fw-bold">T</span>
			<span class="text-warning fw-bold">a</span><span class="text-success fw-bold">s</span>
			<span class="text-primary fw-bold">k</span><span class="text-danger font-monospace">Man</span>
			<span class="text-white font-monospace">agem</span><span class="text-success font-monospace">ent</span>
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item">
					<a class="nav-link text-white" href="#">Hello, <%= (userName != null) ? userName : "Guest" %></a>
				</li>
				<% if (userName != null) { %>
				<li class="nav-item">
					<a class="nav-link text-danger" href="<%= request.getContextPath() %>/logout.jsp">Logout</a>
				</li>
				<% } %>
			</ul>
		</div>
	</div>
</nav>

<!-- Page Layout -->
<div class="container-fluid">
	<div class="row">
		<!-- Sidebar -->
		<nav class="col-md-2 bg-primary p-0 min-vh-100">
			<ul class="nav flex-column pt-3">
				<li class="nav-item">
					<a class="nav-link active text-white fs-5 px-3" href="<%= request.getContextPath() %>/pages/addTask.jsp">➕ Add Task</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active text-white fs-5 px-3" href="<%= request.getContextPath() %>/project/addproject.jsp">
						<i class="fa-solid fa-square-plus" style="color: black;"></i> Add Project
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active text-white fs-5 px-3" href="<%= request.getContextPath() %>/project/projectDetails.jsp">
						<i class="fa-solid fa-list-check" style="color: black;"></i> View Project
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-white fs-5 px-3" href="<%= request.getContextPath() %>/pages/getdetails.jsp">📋 Pending Tasks</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-white fs-5 px-3" href="<%= request.getContextPath() %>/pages/completeTask.jsp">✅ Completed Tasks</a>
				</li>
			</ul>
		</nav>

		<!-- Main Content -->
		<main class="col-md-10 p-4">
			<div class="container">

				<%
				try {
					// Fetch project details
					String projectSql = "SELECT p.title, p.description, p.deadline, p.status, u.username AS created_by FROM projects p JOIN user u ON p.created_by = u.uid WHERE p.project_id = ?";
					st = cn.prepareStatement(projectSql);
					st.setInt(1, projectId);
					rs = st.executeQuery();
					if (rs.next()) {
						title = rs.getString("title");
						description = rs.getString("description");
						deadline = rs.getString("deadline");
						createdBy = rs.getString("created_by");
						status = rs.getString("status");
					}
					rs.close();
					st.close();
				%>

				<!-- Project Overview -->
				<div class="card shadow mb-4">
					<div class="card-header">📋 Project Overview</div>
					<div class="card-body">
						<p><strong>Title:</strong> <%= title %></p>
						<p><strong>Description:</strong> <%= description %></p>
						<p><strong>Deadline:</strong> <%= deadline %></p>
						<p><strong>Created By:</strong> <%= createdBy %></p>
						<p><strong>Status:</strong> <%= status %></p>
					</div>
				</div>

			<!-- Project Team -->
<div class="card shadow mb-4">
	<div class="card-header">👥 Project Team</div>
	<div class="card-body">
		<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
			<%
			try {
				String teamSql = "SELECT username, role FROM project_team WHERE project_id = ?";
				st = cn.prepareStatement(teamSql);
				st.setInt(1, projectId);
				rs = st.executeQuery();
				int memberCount = 1;
				while (rs.next()) {
			%>
			<div class="col">
				<div class="card h-100 shadow-sm border-primary">
					<div class="card-body">
						<h5 class="card-title">👤 <%= rs.getString("username") %></h5>
						<p class="card-text mb-1"><strong>Role:</strong> <%= rs.getString("role") %></p>
						<p class="text-muted small">Member <%= memberCount++ %></p>
					</div>
				</div>
			</div>
			<%
				}
				rs.close();
				st.close();
			} catch (Exception e) {
				out.println("<div class='text-danger'>Error loading team: " + e.getMessage() + "</div>");
			}
			%>
		</div>
	</div>
</div>


				<!-- Timeline -->
				<h5 class="text-primary">🕒 Update Timeline</h5>
				<div class="timeline">
					<%
					String updateSql = "SELECT u.username AS updated_by_username, pu.work_done, pu.update_date FROM project_updates pu JOIN user u ON pu.updated_by = u.uid WHERE pu.project_id = ? ORDER BY pu.update_date ASC";
					st = cn.prepareStatement(updateSql);
					st.setInt(1, projectId);
					rs = st.executeQuery();

					boolean hasUpdates = false;
					while (rs.next()) {
						hasUpdates = true;
					%>
					<div class="timeline-entry">
						<div class="card shadow-sm">
							<div class="card-body">
								<p class="mb-1"><strong>Updated By:</strong> <%= rs.getString("updated_by_username") %></p>
								<p class="mb-1"><strong>Work Done:</strong> <%= rs.getString("work_done") %></p>
								<p class="mb-0"><strong>Date:</strong> <%= rs.getString("update_date") %></p>
							</div>
						</div>
					</div>
					<% } if (!hasUpdates) { %>
						<div class="text-muted">No updates available yet for this project.</div>
					<% }
					} catch (Exception e) {
						out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
					} finally {
						if (rs != null) try { rs.close(); } catch (SQLException e) {}
						if (st != null) try { st.close(); } catch (SQLException e) {}
					}
					%>
				</div>

				<!-- Back Button -->
				<div class="d-grid col-md-1 mx-auto mt-4">
					<a href="projectDetails.jsp" class="btn btn-success">⬅ Back</a>
				</div>

			</div> <!-- container -->
		</main>
	</div>
</div>

<%@ include file="../HTML/footer.html" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
