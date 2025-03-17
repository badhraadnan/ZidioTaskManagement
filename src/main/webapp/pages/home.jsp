<%@page import="com.TaskManagement.Model.DAOServiceImpl"%>
<%@page import="com.TaskManagement.Model.DAOService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String userName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Managment</title>

 <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX+3pBnMFcV7oQPJkl9QevSCWr3W6A==" 
        crossorigin="anonymous" referrerpolicy="no-referrer" />
  
  
</head>
<body>

  
  <nav class="navbar navbar-expand-lg navbar-light bg-dark ">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand text-white" href="#">
        <span class="text-danger fw-bold fst-italic">Z</span><span class="text-white fst-italic">i</span><span class="text-primary fw-light fst-italic">d</span><span class="text-white fst-italic">i</span><span class="text-secondary fst-italic">o</span>
        <span class="text-danger fw-bold">T</span><span class="text-warning fw-bold">a</span><span class="text-success fw-bold">s</span><span class="text-primary fw-bold">k</span>
        <span class="text-danger font-monospace">Man</span><span class="text-white font-monospace">agem</span><span class="text-success font-monospace">ent</span>
        
        </a>


        <!-- Toggler for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
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
                        <a class="nav-link text-danger" href="logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Left Sidebar (col-md-3) -->
        <nav class="col-md-2 bg-primary vh-100 p-3">
           
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active text-white fs-5" href="pages/addTask.jsp">➕ Add Task</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fs-5" href="pages/getdetails.jsp">📋 Pending Tasks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fs-5" href="pages/completeTask.jsp">✅ Completed Tasks</a>
                </li>
                
            </ul>
        </nav>

        <!-- Main Content (col-md-9) -->
        <main class="col-md-9 p-4 bg-white mt-5 text-center">
            <h1 style="font-size: 80px; margin-top: 50px">
            <span class="text-primary" >Welcome to</span><br> 
            <span class="text-danger fw-bold">Zidio</span><br> 
            <span class="text-dark text-decoration-underline">TaskManagement</span>
            
            </h1>
            <%
   
    Integer userId = (Integer) session.getAttribute("userId");
    
    LocalDate currDate = LocalDate.now();  // Current Date
    LocalTime currTime = LocalTime.now();  // Current Time
    
    StringBuilder overdueTasks = new StringBuilder(); // Store overdue tasks

    if (userId != null) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");

            // Get all pending tasks for the user
            String query = "SELECT title, due_time, end_date FROM task WHERE uid = ? AND status = ?";
            ps = cn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, "InProgress");
            rs = ps.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                String endDateStr = rs.getString("end_date");
                String dueTimeStr = rs.getString("due_time") != null ? rs.getString("due_time") : "23:59";

                LocalDate endDate = LocalDate.parse(endDateStr);
                LocalTime dueTime = LocalTime.parse(dueTimeStr, DateTimeFormatter.ofPattern("HH:mm"));

                // Check if the task is overdue
                if (endDate.isBefore(currDate) || (endDate.isEqual(currDate) && currTime.isAfter(dueTime))) {
                    overdueTasks.append("Task '").append(title).append("' is overdue!\\n");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        }
    }
%>
        </main>
    </div>
</div>

 <%@ include file="../HTML/footer.html" %>
  
  <script>
    
    
    let overdueTasks = "<%= overdueTasks.toString() %>";
    if (overdueTasks.trim() !== "") {
        alert(overdueTasks);
    }
</script>
	
</body>
</html>