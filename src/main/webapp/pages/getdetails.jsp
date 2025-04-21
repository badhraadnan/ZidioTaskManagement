<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
int userId = (Integer) session.getAttribute("userId");
LocalDate currDate = LocalDate.now();
StringBuilder dueTasks = new StringBuilder();
%>

<%@ include file="../Database/dbcon.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Task Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
html, body { height: 100%; }
body { display: flex; flex-direction: column; }
main { flex: 1; }
.task-card {
	border-radius: 15px;
	transition: transform 0.2s ease-in-out, box-shadow 0.2s;
}
.task-card:hover {
	transform: translateY(-5px);
	box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
}
.badge-priority-high { background-color: #dc3545; color: white; }
.badge-priority-medium { background-color: #ffc107; color: black; }
.badge-priority-low { background-color: #198754; color: white; }
.badge-inprogress { background-color: #17a2b8; color: white; }
</style>
</head>
<body>

<%@ include file="header.jsp"%>

<main class="col-md-10 p-4">
	<h2 class="text-center text-primary mb-4">Task Details</h2>
	<div class="row" id="taskContainer">
	<%
	PreparedStatement ps = null;
	ResultSet rs = null;
	boolean hasTasks = false;
	try {
		ps = cn.prepareStatement("SELECT tid, title, status, end_date, priority FROM task WHERE uid = ? AND status = ?");
		ps.setInt(1, userId);
		ps.setString(2, "InProgress");
		rs = ps.executeQuery();

		while (rs.next()) {
			hasTasks = true;
			int tid = rs.getInt("tid");
			String title = rs.getString("title");
			String status = rs.getString("status");
			String endDateStr = rs.getString("end_date");
			String priority = rs.getString("priority");
			LocalDate endDate = LocalDate.parse(endDateStr);

			String cardClass = (endDate.isBefore(currDate) || endDate.isEqual(currDate)) ? "bg-warning-subtle" : "bg-light";
			
			String priorityClass = "badge-priority-low";
			if ("High".equalsIgnoreCase(priority)) priorityClass = "badge-priority-high";
			else if ("Medium".equalsIgnoreCase(priority)) priorityClass = "badge-priority-medium";
	%>
	<div class="col-md-4 mb-4 task-card">
	<div class="card shadow border-0 <%=cardClass%>">
		<div class="card-body">
			<!-- Title with Priority Badge on the Right -->
			<div class="d-flex align-items-center justify-content-between mb-1">
				<h5 class="card-title text-primary mb-0">
					<i class="fa-solid fa-tasks me-2"></i><%=title%>
				</h5>
				<span class="badge <%=priorityClass%>"><%=priority%></span>
			</div>

			<!-- Status below title -->
			<p class="mb-2">
				 
				<p class="mb-2"><strong>Status:</strong>  <span class="badge badge-inprogress"><%=status%></span> </p>
			

			<!-- End Date -->
			<p class="mb-2"><strong>End Date:</strong> <%=endDateStr%></p>

			<!-- Action Buttons -->
			<div class="d-flex justify-content-between mt-3">
				<a href="deleteTask.jsp?tid=<%=tid%>" class="btn btn-sm btn-outline-danger">
					<i class="fas fa-trash me-1"></i>Delete
				</a>
				<a href="updateTask.jsp?tid=<%=tid%>" class="btn btn-sm btn-outline-success">
					<i class="fas fa-check me-1"></i>Complete
				</a>
			</div>
		</div>
	</div>
</div>

	<%
		if (endDate.isEqual(currDate) || endDate.isAfter(currDate)) {
			dueTasks.append("<div><strong>").append(title).append("</strong> (").append(endDateStr)
			.append(") is overdue.</div>");
		}
		}
		if (!hasTasks) {
	%>
	
	
		<div class="col-12">
			<div class="alert alert-info text-center fs-5">
				<i class="fas fa-info-circle me-2"></i>No in-progress tasks found.
			</div>
		</div>
	<%
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) rs.close();
		if (ps != null) ps.close();
		if (cn != null) cn.close();
	}
	%>
	</div>
	<%@ include file="dashboard.jsp"%>
</main>

<%@ include file="../HTML/footer.html"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Overdue Task Alert -->
<script>
let dueTasks = `<%=dueTasks.toString()%>`;
if (dueTasks.trim() !== "") {
	Swal.fire({
		
		title: "Warning!",
		html: dueTasks,
		icon: "warning",
		confirmButtonText: "OK",
		confirmButtonColor: "#ffbf00"
	});
}
</script>



</body>
</html>
