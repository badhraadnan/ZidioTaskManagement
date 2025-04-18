<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
int userId = (Integer) session.getAttribute("userId");
LocalDate currDate = LocalDate.now();
LocalTime currTime = LocalTime.now();
StringBuilder dueTasks = new StringBuilder();
%>

<%@ include file="../Database/dbcon.jsp"%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Task Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>

	<%@ include file="header.jsp"%>

	<main class="col-md-9 p-4">
		<div class="table-container mt-5">
			<h2 class="text-center text-primary mb-4">Task Details</h2>
			<div class="table-responsive">
				<table class="table table-striped">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Title</th>
							<th>Status</th>
							<th>End Date</th>
							<th>Delete</th>
							<th>Complete</th>
						</tr>
					</thead>
					<tbody>
						<%
						PreparedStatement ps = null;
						ResultSet rs = null;
						try {
							ps = cn.prepareStatement("SELECT tid, title, status, end_date FROM task WHERE uid = ? AND status = ?");
							ps.setInt(1, userId);
							ps.setString(2, "InProgress");
							rs = ps.executeQuery();
							int count = 1;

							while (rs.next()) {
								String title = rs.getString("title");
								String endDateStr = rs.getString("end_date");
								LocalDate endDate = LocalDate.parse(endDateStr);
						%>
						<tr>
							<td><%=count++%></td>
							<td><%=title%></td>
							<td><%=rs.getString("status")%></td>
							<td><%=endDateStr%></td>
							<td><a href="deleteTask.jsp?tid=<%=rs.getInt("tid")%>"
								class="text-danger"><i class="fas fa-trash"></i></a></td>
							<td><a href="updateTask.jsp?tid=<%=rs.getInt("tid")%>"
								class="text-success"><i class="fas fa-check"></i></a></td>
						</tr>
						<%
						if (endDate.isEqual(currDate) || endDate.isBefore(currDate)) {
							dueTasks.append("<div style='color: red; font-weight: bold; padding: 5px; background-color: yellow;'>")
							.append(endDateStr).append("<br>").append("Task <strong>").append(title).append("</strong> is overdue!")
							.append("</div>");
						}
						}
						} catch (Exception e) {
						e.printStackTrace();
						} finally {
						if (rs != null)
						rs.close();
						if (ps != null)
						ps.close();
						if (cn != null)
						cn.close();
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</main>

	<%@ include file="dashboard.jsp"%>
	<%@ include file="../HTML/footer.html"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<%-- Alert for overdue tasks --%>
	<script>
let dueTasks = `<%=dueTasks.toString()%>
		`;
		if (dueTasks.trim() !== "") {
			Swal.fire({
				title : "Overdue Task!",
				html : dueTasks,
				icon : "warning",
				confirmButtonText : "OK",
				confirmButtonColor : "#d33"
			});
		}
	</script>

</body>
</html>
