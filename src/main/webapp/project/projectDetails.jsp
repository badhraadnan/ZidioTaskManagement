<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
.project-card {
	transition: transform 0.2s ease-in-out;
	border-radius: 16px;
}

.project-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.card-header {
	border-radius: 16px 16px 0 0;
}

.badge-role {
	font-size: 0.85rem;
}

.text-small {
	font-size: 0.9rem;
}

.card-footer {
	background-color: #f8f9fa;
}
</style>
</head>
<body>

	<%@ include file="../pages/header.jsp"%>
	<%@ include file="../Database/dbcon.jsp"%>

	<main class="col-md-9 p-2 container my-3">
		<h2 class="text-center text-primary fw-bold mb-5">Your Project
			Dashboard</h2>
		<div class="row g-4">

			<%
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				ps = cn.prepareStatement(
				"SELECT p.title, p.description, u.username AS created_by_username,p.status, p.deadline, pt.role, p.project_id "
						+ "FROM project_team pt " + "JOIN projects p ON pt.project_id = p.project_id "
						+ "JOIN user u ON p.created_by = u.uid " + "WHERE pt.username = ? ");
				ps.setString(1, userName);
				rs = ps.executeQuery();

				String[] colors = {"primary", "success", "info", "warning", "danger", "secondary"};
				int colorIndex = 0;

				while (rs.next()) {
					String title = rs.getString("title");
					String desc = rs.getString("description");
					String creatorUsername = rs.getString("created_by_username");
					String status = rs.getString("status");
					String deadline = rs.getString("deadline");
					String role = rs.getString("role");
					int projectId = rs.getInt("project_id");

					String cardColor = colors[colorIndex % colors.length];
					colorIndex++;
			%>

			<!-- Project Card -->
			<div class="col-lg-4 col-md-6">
				<div class="card project-card border-0 shadow-sm">
					<div class="card-header bg-<%=cardColor%> text-white">
						<h5 class="mb-0 text-center"><%=title%></h5>
					</div>
					<div class="card-body bg-light">
						<p class="mb-2">
							<span class="badge bg-<%=cardColor%> badge-role"> <i
								class="fas fa-user-tag me-1"></i> <%=role%>
							</span>
						</p>
						<p class="text-small">
							<i class="fas fa-align-left me-2"></i><strong>Description:</strong>
							<%=desc%>
						</p>
						<p class="text-small">
							<i class="fas fa-user me-2"></i><strong>Created By:</strong>
							<%=creatorUsername%>
						</p>
						<p class="text-small">
							<i class="fas fa-calendar-alt me-2"></i><strong>Deadline:</strong>
							<span class="text-danger fw-semibold"><%=deadline%></span>
						</p>
						<p class="text-small">
							<%-- Show status icon before "Status:" label --%>
							<%
							if ("Completed".equalsIgnoreCase(status)) {
							%>
							<i class="fas fa-check-circle text-success me-2"></i>
							<%
							} else if ("In Progress".equalsIgnoreCase(status)) {
							%>
							<i class="fas fa-spinner fa-spin text-warning me-2"></i>
							<%
							} else {
							%>
							<i class="fas fa-hourglass-start text-secondary me-2"></i>
							<%
							}
							%>

							<strong>Status:</strong> <span
								class="text-success fw-semibold ms-1"><%=status%></span>
						</p>

					</div>
					<div class="card-footer text-center">
						<!-- View More button is always shown -->
						<a href="viewProject.jsp?projectId=<%=projectId%>"
							class="btn btn-outline-primary btn-sm"> <i
							class="fas fa-eye me-2"></i>View More
						</a>

						<!-- Edit button shown only if project is InProgress -->
						<%
						if ("InProgress".equalsIgnoreCase(status)) {
						%>
						<a href="updateProject.jsp?projectId=<%=projectId%>"
							class="btn btn-outline-success btn-sm"> <i
							class="fas fa-edit me-2"></i>Edit
						</a>
						<%
						}
						%>

						<!-- Update button shown only to creator or admin when InProgress -->
						<%
						if ((userName.equals(creatorUsername) || userName.equals("admin")) && "InProgress".equalsIgnoreCase(status)) {
						%>
						<a href="completeProject.jsp?projectId=<%=projectId%>"
							class="btn btn-outline-warning btn-sm"> <i class="fas fa-check me-2"></i>
						</a>
						<%
						}
						%>

						<!-- Delete button shown only to creator or admin when complete -->
						<%
						if ((userName.equals(creatorUsername) || userName.equals("admin"))) {
						%>
						<a href="deleteProject.jsp?projectId=<%=projectId%>"
							class="btn btn-outline-danger btn-sm"> <i
							class="fas fa-trash me-2"></i>
						</a>
						<%
						}
						%>
					</div>

				</div>
			</div>

			<%
			} // end while
			} catch (Exception e) {
			e.printStackTrace();
			%>
			<div class="col-12">
				<div class="alert alert-danger">Error fetching project data.</div>
			</div>
			<%
			} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (cn != null)
				cn.close();
			}
			%>

		</div>
	</main>

	<%@ include file="../HTML/footer.html"%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// Enable tooltips
		var tooltipTriggerList = [].slice.call(document
				.querySelectorAll('[data-bs-toggle="tooltip"]'))
		var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
			return new bootstrap.Tooltip(tooltipTriggerEl)
		});
	</script>

</body>
</html>
