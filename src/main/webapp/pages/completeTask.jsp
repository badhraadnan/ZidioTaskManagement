<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

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
.task-card {
	border-radius: 15px;
	transition: transform 0.2s ease-in-out, box-shadow 0.2s;
}
.task-card:hover {
	transform: translateY(-5px);
	box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
}
.badge-pending {
	background-color: #ffc107;
	color: black;
}
.badge-completed {
	background-color: #28a745;
}
.badge-inprogress {
	background-color: #17a2b8;
}
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

	<%@ include file="header.jsp"%>
	<%@ include file="../Database/dbcon.jsp"%>

	<!-- Main Content -->
	<main class="col-md-10 p-4">
		<h2 class="text-center text-primary mb-4">Task Details</h2>

		<!-- Task Cards -->
		<div class="row" id="taskContainer">
			<%
			PreparedStatement ps = null;
			ResultSet rs = null;
			boolean hasTasks = false;
			try {
				ps = cn.prepareStatement(
				"SELECT title, status, priority, user.username FROM user JOIN task ON user.uid = task.uid where user.username=? and status='complete'");
				ps.setString(1, userName);
				
				rs = ps.executeQuery();

				while (rs.next()) {
					hasTasks = true;
					String title = rs.getString("title");
					String status = rs.getString("status").trim().toLowerCase();
					String statusNormalized = status.equals("complete") ? "completed" : status;
					String priority = rs.getString("priority").trim();
					String username = rs.getString("username");

					String bgClass = "bg-light";
					if (priority.equalsIgnoreCase("High")) {
						bgClass = "bg-danger-subtle";
					} else if (priority.equalsIgnoreCase("Medium")) {
						bgClass = "bg-warning-subtle";
					} else if (priority.equalsIgnoreCase("Low")) {
						bgClass = "bg-success-subtle";
					}
			%>

			<div class="col-md-4 mb-4 task-card"
				data-priority="<%=priority.toLowerCase()%>"
				data-status="<%=statusNormalized%>">
				<div class="card shadow border-0 <%=bgClass%>">
					<div class="card-body">
						<div class="d-flex justify-content-between align-items-center">
							<h5 class="card-title text-primary mb-0">
								<i class="fa-solid fa-tasks me-2"></i><%=title%></h5>
							<span
								class="badge 
								<%=priority.equalsIgnoreCase("High") ? "bg-danger"
								: (priority.equalsIgnoreCase("Medium") ? "bg-warning text-dark" : "bg-success")%>">
								<%=priority%>
							</span>
						</div>
						<p class="card-text mt-2">
							<strong>User:</strong> <%=username%>
						</p>
						<p>
							<strong>Status:</strong>
							<%
							if (statusNormalized.equals("pending")) {
							%>
							<span class="badge badge-pending">Pending</span>
							<%
							} else if (statusNormalized.equals("inprogress")) {
							%>
							<span class="badge badge-inprogress">In Progress</span>
							<%
							} else {
							%>
							<span class="badge badge-completed">Completed</span>
							<%
							}
							%>
						</p>
					</div>
				</div>
			</div>
			<%
				}
				if (!hasTasks) {
			%>
			<div class="col-12">
				<div class="alert alert-info text-center fs-5">
					<i class="fas fa-info-circle me-2"></i>No tasks found for this user.
				</div>
			</div>
			<%
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (cn != null) cn.close();
				if (ps != null) ps.close();
			}
			%>
		</div>
			<%@ include file="dashboard.jsp"%>
	</main>

	<%@ include file="../HTML/footer.html"%>

	<!-- Bootstrap Bundle -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
