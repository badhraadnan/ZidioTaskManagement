<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

     <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>

    <div class="login-card">
        <h2><i class="fas fa-user-lock"></i> Login Here</h2>

        <form action="verify" method="post">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" placeholder="Enter Username" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
            </div>

            <button type="submit" class="btn btn-login w-100"><i class="fas fa-sign-in-alt"></i> Login</button>

            <p class="mt-3">
                Don't have an account? <a href="pages/register.jsp" class="register-link">Register Here</a>
            </p>
            <p class="mt-3">
                <a href="adminlogin.jsp" class="register-link">Admin Login</a>
            </p>

            <!-- Error Message -->
            <div class="error-message">
                <%
                if (request.getAttribute("error") != null) {
                    out.println(request.getAttribute("error") + "!");
                }
                %>
            </div>
        </form>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
