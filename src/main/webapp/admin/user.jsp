<%@page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userName = (String) session.getAttribute("userName");
    String search = request.getParameter("search");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Custom Styles -->
    <style>
        body, html {
            height: 100%;
        }

        .sidebar {
            background: linear-gradient(to bottom, #007bff, #0056b3);
            color: white;
            padding-top: 20px;
            height: 100vh;
        }

        .sidebar .nav-link {
            color: white;
            font-size: 18px;
            padding: 12px 15px;
        }

        .sidebar .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
        }

        .navbar {
            background: #343a40;
        }

        .navbar .navbar-brand {
            font-size: 24px;
            font-weight: bold;
        }

        footer {
            background: #343a40;
            color: white;
            padding: 10px 0;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <span class="text-danger">Z</span><span class="text-white">i</span><span class="text-primary">d</span><span class="text-white">i</span><span class="text-secondary">o</span>
            <span class="text-danger">T</span><span class="text-warning">a</span><span class="text-success">s</span><span class="text-primary">k</span>
        	<span class="text-danger font-monospace">Man</span><span class="text-white font-monospace">agem</span><span class="text-success font-monospace">ent</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link text-white">Hello, <%= (userName != null) ? userName : "Guest" %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="../admin/logout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container-fluid flex-grow-1">
    <div class="row min-vh-100">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar d-flex flex-column align-items-start">
            <ul class="nav flex-column w-100">
                <li class="nav-item">
                    <a class="nav-link active" href="viewTask.jsp"><i class="fa-solid fa-list-check me-2"></i> View Task</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="user.jsp"><i class="fa-solid fa-people-roof me-2"></i> Manage Users</a>
                </li>
            </ul>
        </nav>

        <!-- Content -->
        <main class="col-md-10 p-4">
            <h2 class="text-center text-primary mb-4">User Management</h2>

            <!-- Search Form -->
            <form method="get" class="mb-4 ">
                <div class="input-group w-50" style="margin-left: 50%;">
                    <input type="text" name="search" value="<%= (search != null) ? search : "" %>" class="form-control" placeholder="Search by Username">
                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i> Search</button>
                </div>
            </form>

            <!-- User Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center">
                    <thead class="bg-dark text-white">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Mobile</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection cn = null;
                            PreparedStatement ps = null;
                            int id = 1;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp", "root", "Adnan");

                                String query = "SELECT * FROM user";
                                if (search != null && !search.trim().isEmpty()) {
                                    query += " WHERE username LIKE ?";
                                    ps = cn.prepareStatement(query);
                                    ps.setString(1, "%" + search + "%");
                                } else {
                                    ps = cn.prepareStatement(query);
                                }

                                ResultSet rs = ps.executeQuery();

                                while (rs.next()) {
                                    String name = rs.getString("name");
                                    String username = rs.getString("username");
                                    String mobile = rs.getString("mobile");
                                    String email = rs.getString("email");
                                    String password = rs.getString("password");
                        %>
                        <tr>
                            <td><%= id++ %></td>
                            <td><%= name %></td>
                            <td><%= username %></td>
                            <td><%= mobile %></td>
                            <td><%= email %></td>
                            <td><%= password %></td>
                            <td>
                                <a href="userdelete.jsp?uid=<%= rs.getInt("uid") %>" class="text-danger">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (ps != null) ps.close();
                                if (cn != null) cn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<!-- Footer -->
<footer class="mt-auto text-center">
    <div class="container">
        <p class="mb-0">© 2025 Zidio Task Management. All rights reserved.</p>
        
        <div>
            <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
            <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in"></i></a>
            <a href="#" class="text-white"><i class="fab fa-github"></i></a>
        </div>
    </div>
</footer>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
