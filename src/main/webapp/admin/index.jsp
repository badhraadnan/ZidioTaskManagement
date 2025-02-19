<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.PreparedStatement, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userName = (String) session.getAttribute("userName");

    int totalUsers = 0;
    int totalTasks = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");

        // Count Users
        PreparedStatement ps1 = cn.prepareStatement("SELECT COUNT(*) FROM user");
        ResultSet rs1 = ps1.executeQuery();
        if (rs1.next()) {
            totalUsers = rs1.getInt(1);
        }

        // Count Tasks
        PreparedStatement ps2 = cn.prepareStatement("SELECT COUNT(*) FROM task");
        ResultSet rs2 = ps2.executeQuery();
        if (rs2.next()) {
            totalTasks = rs2.getInt(1);
        }

        rs1.close();
        ps1.close();
        rs2.close();
        ps2.close();
        cn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Task Management Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="stylesheet" href="CSS/admin_style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">
            <span class="text-danger fw-bold">Zidio</span>
            <span class="text-white">Task Management</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link text-white" href="#">Hello, <%= (userName != null) ? userName : "Guest" %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#contact">Contact</a>
                </li>
                <% if (userName != null) { %>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="../admin/logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 bg-primary vh-100 p-3">
            <ul class="nav flex-column">
                <li class="nav-item mt-4">
                    <a class="nav-link active text-white fs-5" href="admin/viewTask.jsp">
                        <i class="fa-solid fa-list-check text-white"></i> View Task
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fs-5" href="admin/user.jsp">
                        <i class="fa-solid fa-people-roof text-white"></i> Manage User
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 p-4 bg-white mt-5 text-center">
            <div class="row mt-4">
                <!-- Total Users Card -->
                <div class="col-md-6">
                    <div class="card text-white bg-success mb-3 shadow">
                        <div class="card-body text-center">
                            <h5 class="card-title">Total Users</h5>
                            <h2><%= totalUsers %></h2>
                        </div>
                    </div>
                </div>

                <!-- Total Tasks Card -->
                <div class="col-md-6">
                    <div class="card text-white bg-info mb-3 shadow">
                        <div class="card-body text-center">
                            <h5 class="card-title">Total Tasks</h5>
                            <h2><%= totalTasks %></h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chart Container -->
            <div class="row justify-content-center mt-5">
                <div class="col-md-6">
                    <canvas id="taskUserChart"></canvas>
                </div>
            </div>

            <!-- Welcome Message -->
            
        </main>
    </div>
</div>

<!-- Footer -->
<%@ include file="../HTML/footer.html" %>

<!-- Chart.js Script -->
<script>
    var ctx = document.getElementById("taskUserChart").getContext("2d");
    var taskUserChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: ["Users", "Tasks"],
            datasets: [{
                label: "Count",
                data: [<%= totalUsers %>, <%= totalTasks %>],
                backgroundColor: ["#007bff", "#28a745"],
                borderColor: ["#0056b3", "#1c7430"],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
