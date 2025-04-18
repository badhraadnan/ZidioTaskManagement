<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  
    Integer userId = (Integer) session.getAttribute("userId");

    LocalDate currDate = LocalDate.now(); // Current Date
    LocalTime currTime = LocalTime.now(); // Current Time

    StringBuilder overdueTasks = new StringBuilder(); // Store overdue tasks

    int totalTask = 0;
    int pendingTask = 0;

    if (userId != null) {
        Connection cn = null;
        PreparedStatement ps = null, ps2 = null, ps3 = null;
        ResultSet rs = null, rs2 = null, rs3 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");

            // Get all pending tasks
            String query = "SELECT title, end_date FROM task WHERE uid = ? AND status = ?";
            ps = cn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, "InProgress");
            rs = ps.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                String endDateStr = rs.getString("end_date");
                LocalDate endDate = LocalDate.parse(endDateStr);

                if (endDate.isBefore(currDate)) {
                    overdueTasks.append("Task '").append(title).append("' is overdue!\\n");
                }
            }

            // Count total tasks
            ps2 = cn.prepareStatement("SELECT COUNT(*) FROM task WHERE uid=?");
            ps2.setInt(1, userId);
            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                totalTask = rs2.getInt(1);
            }

            // Count pending tasks
            ps3 = cn.prepareStatement("SELECT COUNT(*) FROM task WHERE uid=? AND status='InProgress'");
            ps3.setInt(1, userId);
            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                pendingTask = rs3.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (rs2 != null) rs2.close();
            if (ps2 != null) ps2.close();
            if (rs3 != null) rs3.close();
            if (ps3 != null) ps3.close();
            if (cn != null) cn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Task Management</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX+3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>

<%@ include file="header.jsp" %>

<!-- Main Content (10 columns) -->
<main class="col-md-10 p-4 bg-white text-center">
    <h1 style="font-size: 80px; margin-top: 50px">
        <span class="text-primary">Welcome to</span><br>
        <span class="text-danger fw-bold">Zidio</span><br>
        <span class="text-dark text-decoration-underline">TaskManagement</span>
    </h1>

    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card text-white bg-success mb-3 shadow" style="height: 200px;">
                <div class="card-body text-center">
                    <h2 class="card-title mt-5">Total Tasks</h2>
                    <h2><%= totalTask %></h2>
                </div>
            </div>
        </div>

        <div class="col-md-4"></div>

        <div class="col-md-4">
            <div class="card text-white bg-info mb-3 shadow" style="height: 200px;">
                <div class="card-body text-center">
                    <h2 class="card-title mt-5">Pending Tasks</h2>
                    <h2><%= pendingTask %></h2>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="dashboard.jsp" %>
</main>

    </div> <!-- close row -->
</div> <!-- close container -->

<%@ include file="../HTML/footer.html" %>

<!-- Alert Script -->
<script>
    let overdueTasks = "<%= overdueTasks.toString().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") %>";
    if (overdueTasks.trim() !== "") {
        alert(overdueTasks);
    }
</script>


</body>
</html>
