<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%
String userName = (String) session.getAttribute("userName");
Integer userId = (Integer) session.getAttribute("userId");
LocalDate currDate = LocalDate.now();
LocalTime currTime = LocalTime.now();
StringBuilder overdueTasks = new StringBuilder();
int totalTask = 0, pendingTask = 0, totalProject = 0;

if (userId != null) {
	try (Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");
	PreparedStatement ps = cn.prepareStatement("SELECT title, end_date FROM task WHERE uid = ? AND status = ?");
	PreparedStatement ps2 = cn.prepareStatement("SELECT COUNT(*) FROM task WHERE uid=?");
	PreparedStatement ps3 = cn
			.prepareStatement("SELECT COUNT(*) FROM task WHERE uid=? AND status='InProgress'");
	PreparedStatement ps4 = cn.prepareStatement(
			"SELECT COUNT(DISTINCT pt.project_id) AS total_projects FROM user u JOIN project_team pt ON u.username = pt.username WHERE u.uid =?");) {

		Class.forName("com.mysql.cj.jdbc.Driver");
		ps.setInt(1, userId);
		ps.setString(2, "InProgress");
		try (ResultSet rs = ps.executeQuery()) {
	while (rs.next()) {
		String title = rs.getString("title");
		LocalDate endDate = LocalDate.parse(rs.getString("end_date"));
		

		if (endDate.isEqual(currDate)) {
		    overdueTasks.append("Task '").append(title).append("' is overdue!\n");
		}

		// Store overdueTasks in request attribute if you're using JSP
		request.setAttribute("overdueTasks", overdueTasks.toString());

	}
		}

		ps2.setInt(1, userId);
		try (ResultSet rs2 = ps2.executeQuery()) {
	if (rs2.next())
		totalTask = rs2.getInt(1);
		}

		ps3.setInt(1, userId);
		try (ResultSet rs3 = ps3.executeQuery()) {
	if (rs3.next())
		pendingTask = rs3.getInt(1);
		}

		ps4.setInt(1, userId);
		try (ResultSet rs4 = ps4.executeQuery()) {
	if (rs4.next())
		totalProject = rs4.getInt(1);
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zidio Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
body {
	background: #f4f7fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.navbar {
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.card {
	border: none;
	border-radius: 20px;
	transition: transform 0.2s ease-in-out;
}

.card:hover {
	transform: scale(1.03);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.card-title {
	font-size: 24px;
	margin-bottom: 10px;
}

.card h2 {
	font-size: 36px;
}

.card-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 20px;
	margin-top: 40px;
}

.card-content h1, .card-content h2 {
	font-weight: bold;
	color: #fff;
}

.card-content p, .card-content a {
	color: #f8f9fa;
}

.card.about-us {
	background: linear-gradient(to right, #00c6ff, #0072ff);
}

.card.mission {
	background: linear-gradient(to right, #ff758c, #ff7eb3);
}

.card.team {
	background: linear-gradient(to right, #43cea2, #185a9d);
}

.card.contact {
	background: linear-gradient(to right, #f7971e, #ffd200);
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand text-white" href="#"> <span
				class="text-danger fw-bold fst-italic">Z</span> <span
				class="text-white fst-italic">i</span> <span
				class="text-primary fw-light fst-italic">d</span> <span
				class="text-white fst-italic">i</span> <span
				class="text-secondary fst-italic">o</span> <span
				class="text-danger fw-bold">T</span> <span
				class="text-warning fw-bold">a</span> <span
				class="text-success fw-bold">s</span> <span
				class="text-primary fw-bold">k</span> <span
				class="text-danger font-monospace">Man</span> <span
				class="text-white font-monospace">agem</span> <span
				class="text-success font-monospace">ent</span>
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link text-white" href="#">Hello,
							<%=(userName != null) ? userName : "Guest"%></a></li>

					<%
					if (userName != null) {
					%>
					<li class="nav-item"><a class="nav-link text-danger"
						href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<nav class="col-md-2 bg-primary p-0">
				<ul class="nav flex-column pt-3">
					<li class="nav-item"><a
						class="nav-link active text-white fs-5 px-3"
						href="<%=request.getContextPath()%>/pages/addTask.jsp">➕ Add
							Task</a></li>

					<li class="nav-item"><a
						class="nav-link active text-white fs-5 px-3"
						href="<%=request.getContextPath()%>/project/addproject.jsp"> <i
							class="fa-solid fa-square-plus"
							style="margin-left: 5px; color: black;"></i> Add Project
					</a></li>
					<li class="nav-item"><a
						class="nav-link active text-white fs-5 px-3"
						href="<%=request.getContextPath()%>/project/projectDetails.jsp">
							<i class="fa-solid fa-list-check"
							style="margin-left: 5px; color: black;"></i> view Project
					</a></li>

					<li class="nav-item"><a class="nav-link text-white fs-5 px-3"
						href="<%=request.getContextPath()%>/pages/getdetails.jsp">📋
							Pending Tasks</a></li>

					<li class="nav-item"><a class="nav-link text-white fs-5 px-3"
						href="<%=request.getContextPath()%>/pages/completeTask.jsp">✅
							Completed Tasks</a></li>

				</ul>
			</nav>
			<main class="col-md-10 ms-sm-auto px-md-4">
				<div class="row text-center mt-4">
					<div class="col-md-4">
						<div class="card bg-success text-white p-4">
							<h2 class="card-title">Total Tasks</h2>
							<h2><%=totalTask%></h2>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card bg-info text-white p-4">
							<h2 class="card-title">Pending Tasks</h2>
							<h2><%=pendingTask%></h2>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card bg-secondary text-white p-4">
							<h2 class="card-title">Total Projects</h2>
							<h2><%=totalProject%></h2>
						</div>
					</div>
				</div>

				<div class="card-container mt-5 mb-5">
					<section class="card about-us p-4">
						<div class="card-content">
							<h1>About Zidio Task Management</h1>
							<p>Welcome to Zidio Task Management, your ultimate solution
								for task tracking. Our platform helps individuals and teams stay
								organized, track project progress, and collaborate effectively.</p>
						</div>
					</section>
					<section class="card mission p-4">
						<div class="card-content">
							<h2>Our Mission</h2>
							<p>We aim to offer a user-friendly task management system
								that helps users stay productive. Whether you're working alone
								or with a team, Zidio helps you stay focused on your goals.</p>
						</div>
					</section>
					<section class="card team p-4">
						<div class="card-content">
							<h2>Our Team</h2>
							<p>We're a team of dedicated developers focused on building
								powerful, simple tools for improved workflow. With Zidio,
								productivity becomes effortless.</p>
						</div>
					</section>
					<section class="card contact p-4">
    <div class="card-content">
        <h2>Contact Us</h2>
        <p>
            Have questions or suggestions? Email us at <a href="mailto:support@zidio.com">support@zidio.com</a>.
        </p>
        
        <!-- New Additional Content -->
        <p>
            You can also reach us through the following methods:
        </p>
        
        <!-- Contact Details -->
        <ul>
            <li><strong>Phone:</strong> <a href="tel:+1234567890">+1 (234) 567-890</a></li>
            <li><strong>Address:</strong> 123 Zidio Street, Tech City, ABC 12345</li>
        </ul>

        <!-- Social Media Links -->
        <p>Follow us on social media:</p>
        <div class="social-links">
            <a href="https://www.facebook.com/zidio" target="_blank">Facebook</a> | 
            <a href="https://twitter.com/zidio" target="_blank">Twitter</a> | 
            <a href="https://www.linkedin.com/company/zidio" target="_blank">LinkedIn</a>
        </div>

        <p>If you prefer, feel free to visit our <a href="/support">Support Center</a> for more resources.</p>
    </div>
</section>

				</div>
			</main>
		</div>
	</div>

	<%@ include file="../HTML/footer.html"%>

	<script>
let overdueTasks = "<%= (request.getAttribute("overdueTasks") != null ? 
    request.getAttribute("overdueTasks").toString()
    .replaceAll("\\\\", "\\\\\\\\")
    .replaceAll("\"", "\\\\\"")
    .replaceAll("\n", "\\\\n") 
    : "") %>";

if (overdueTasks.trim() !== "") {
    alert(overdueTasks);
}
</script>

	
	

</body>
</html>