<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add New Project</title>
<!-- Bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	padding: 0%;
}

.card {
	max-width: 700px;
	margin: auto;
	margin-top: 50px;
}
</style>
</head>
<body>

	<%@ include file="../pages/header.jsp"%>

	<%@ page import="javax.servlet.http.HttpSession"%>
	<%
	int userId = (Integer) session.getAttribute("userId");
	%>

	<main class="col-md-10 p-0 bg-light">
		<div class="card shadow p-4">
			<h3 class="mb-4 text-center">Add New Project</h3>
			<form action="<%=request.getContextPath()%>/project/saveproject"
				method="post">
				<div class="mb-3">
					<label class="form-label">Project Title</label> <input type="text"
						name="title" class="form-control" required>
				</div>

				<div class="mb-3">
					<label class="form-label">Description</label>
					<textarea name="description" class="form-control" rows="2" required></textarea>
				</div>

				<input type="hidden" name="created_by" value="<%=userId%>">

				<div class="mb-3">
					<label class="form-label">Deadline</label> <input type="date"
						name="deadline" class="form-control" required>
				</div>

				<h5 class="mt-4">Team Members</h5>

				<div class="row mb-3">
					<div class="col-md-6">
						<input type="text" name="memberUsername0" class="form-control"
							placeholder="Username-1" required />
					</div>
					<div class="col-md-6">
						<input type="text" name="memberRole0" class="form-control"
							placeholder="Role" required />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-6">
						<input type="text" name="memberUsername1" class="form-control"
							placeholder="Username-2" required />
					</div>
					<div class="col-md-6">
						<input type="text" name="memberRole1" class="form-control"
							placeholder="Role" required />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-6">
						<input type="text" name="memberUsername2" class="form-control"
							placeholder="Username-3" required />
					</div>
					<div class="col-md-6">
						<input type="text" name="memberRole2" class="form-control"
							placeholder="Role" required />
					</div>
				</div>

				<div class="d-grid">
					<input type="submit" value="Create Project" class="btn btn-success">
				</div>
			</form>
		</div>
	</main>

</body>
</html>
