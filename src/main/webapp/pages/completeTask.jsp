<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int userId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Completed Tasks</title>

	<!-- Bootstrap and FontAwesome -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
</head>
<body>

	<!-- Navbar + Sidebar -->
	<%@ include file="header.jsp" %>

	<!-- Main content area (col-md-10 for content) -->
	<main class="col-md-10 p-4">
		<div class="table-container mt-3">
			<h2 class="text-center text-primary mb-4">Completed Tasks by Priority</h2>

			<%
			String[] priorities = { "High", "Medium", "Low" };
			String[] colors = { "danger", "warning", "success" };

			for (int i = 0; i < priorities.length; i++) {
				Connection cn = null;
				PreparedStatement ps = null;
				ResultSet rs = null;

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
					ps = cn.prepareStatement("SELECT tid, title, status FROM task WHERE uid = ? AND status = ? AND priority = ?");
					ps.setInt(1, userId);
					ps.setString(2, "Complete");
					ps.setString(3, priorities[i]);
					rs = ps.executeQuery();
			%>

			<div class="card border-<%=colors[i]%> mb-4 shadow-sm">
				<div class="card-header bg-<%=colors[i]%> text-white fs-5">
					<i class="fas fa-flag"></i> <%=priorities[i]%> Priority Tasks
				</div>
				<div class="card-body p-0">
					<table class="table table-striped mb-0">
						<thead class="table-light">
							<tr>
								<th>Id</th>
								<th>Title</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							int count = 1;
							boolean hasData = false;
							while (rs.next()) {
								hasData = true;
							%>
							<tr>
								<td><%=count++%></td>
								<td><%=rs.getString("title")%></td>
								<td><%=rs.getString("status")%></td>
							</tr>
							<%
							}
							if (!hasData) {
							%>
							<tr>
								<td colspan="3" class="text-center text-muted">No completed tasks in this category.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<%
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rs != null) rs.close();
					if (ps != null) ps.close();
					if (cn != null) cn.close();
				}
			}
			%>
		</div>
		<%@ include file="dashboard.jsp" %>
	</main>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<%@ include file="../HTML/footer.html" %>

</body>
</html>
