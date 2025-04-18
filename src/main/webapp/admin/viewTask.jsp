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
				<li class="nav-item"><a class="nav-link active" href="viewTask.jsp"><i class="fa-solid fa-list-check me-2"></i> View Task</a></li>
				<li class="nav-item"><a class="nav-link" href="user.jsp"><i class="fa-solid fa-people-roof me-2"></i> Manage Users</a></li>
			</ul>
		</nav>

		<!-- Main Content -->
		<main class="col-md-10 p-4">
			<h2 class="text-center text-primary mb-4">Task Details</h2>

			<!-- Filter Section -->
			<div class="row mb-4">
			<div class="col-md-1">
				<p style="font-size: 20px;">Filter :</p>
			</div>
				<div class="col-md-2 ">
					<select id="priorityFilter" class="form-select" style="font-size: 12px;">
						<option value="">Filter by Priority</option>
						<option value="high">High</option>
						<option value="medium">Medium</option>
						<option value="low">Low</option>
					</select>
				</div>
				<div class="col-md-2">
					<select id="statusFilter" class="form-select"style="font-size: 12px;">
						<option value="">Filter by Status</option>
						<option value="inprogress">InProgress</option>
						<option value="completed">Completed</option>
					</select>
				</div>
			</div>

			<!-- Task Cards -->
			<div class="row" id="taskContainer">
				<%
				Connection cn = null;
				PreparedStatement ps = null;
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
					ps = cn.prepareStatement("SELECT title, status, priority, user.username FROM user JOIN task ON user.uid = task.uid");
					ResultSet rs = ps.executeQuery();

					while (rs.next()) {
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

				<div class="col-md-4 mb-4 task-card" data-priority="<%=priority.toLowerCase()%>" data-status="<%=statusNormalized%>">
					<div class="card shadow border-0 <%=bgClass%>">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-title text-primary mb-0"><i class="fa-solid fa-tasks me-2"></i><%=title%></h5>
								<span class="badge 
									<%= priority.equalsIgnoreCase("High") ? "bg-danger" :
										(priority.equalsIgnoreCase("Medium") ? "bg-warning text-dark" : "bg-success") %>">
									<%=priority%>
								</span>
							</div>
							<p class="card-text mt-2"><strong>User:</strong> <%=username%></p>
							<p><strong>Status:</strong>
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
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (cn != null) cn.close();
					if (ps != null) ps.close();
				}
				%>
			</div>
		</main>
	</div>
</div>

<%@ include file="../HTML/footer.html" %>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.getElementById("priorityFilter").addEventListener("change", filterTasks);
document.getElementById("statusFilter").addEventListener("change", filterTasks);

function filterTasks() {
    const selectedPriority = document.getElementById("priorityFilter").value.toLowerCase();
    const selectedStatus = document.getElementById("statusFilter").value.toLowerCase();
    const tasks = document.querySelectorAll(".task-card");

    tasks.forEach(task => {
        const taskPriority = task.getAttribute("data-priority").toLowerCase();
        const taskStatus = task.getAttribute("data-status").toLowerCase();

        const priorityMatch = selectedPriority === "" || taskPriority === selectedPriority;
        const statusMatch = selectedStatus === "" || taskStatus === selectedStatus;

        task.style.display = (priorityMatch && statusMatch) ? "block" : "none";
    });
}
</script>

</body>
</html>
