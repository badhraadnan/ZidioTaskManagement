<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>



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

<%@ include file="header.jsp" %>



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
