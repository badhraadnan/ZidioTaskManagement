<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
int projectId = Integer.parseInt(request.getParameter("projectId"));
int userId = (Integer) session.getAttribute("userId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Updates</title>
<!-- Bootstrap CSS CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="../pages/header.jsp" %>
	<main class="col-md-9 p-4">
		<div class="container py-5 mt-5">
			<div class="row justify-content-center">
				<div class="col-md-8">

					<div class="card shadow rounded-4">
						<div class="card-header bg-primary text-white rounded-top-4">
							<h5 class="mb-0 text-center">Project Update</h5>
						</div>

						<div class="card-body">

							<!-- Project Update Form -->
							<form action="<%=request.getContextPath()%>/project/saveUpdate"
								method="post" class="needs-validation" novalidate>
								<!-- Hidden Inputs -->
								<input type="hidden" name="project_id" value="<%=projectId%>">
								<input type="hidden" name="user_id" value="<%=userId%>">

								<!-- Work Done Textarea -->
								<div class="mb-3">
									<label for="work_done" class="form-label my-2">Work Done</label>
									<textarea name="work_done" id="work_done"
										class="form-control rounded-3" rows="2" required
										placeholder="Describe the work completed..."></textarea>
									<div class="invalid-feedback">Please describe the work
										done.</div>
								</div>

								<!-- Submit Button -->
								<div class="d-grid">
									<button type="submit" class="btn btn-success rounded-3 my-2">
										<i class="fas fa-plus-circle me-1"></i> Add Update
									</button>
								</div>
							</form>

						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="d-grid col-md-1 " style="margin-left: 50%;">
					<a href="projectDetails.jsp" class="btn btn-success">⬅ Back</a>
				</div>
	</main>
	<%@ include file="../HTML/footer.html" %>
	<!-- Bootstrap JS and validation script -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    // Bootstrap validation
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

</body>
</html>
