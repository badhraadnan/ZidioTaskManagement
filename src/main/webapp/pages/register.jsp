<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

     <!-- Custom CSS -->
    <link rel="stylesheet" href="../CSS/style.css">
    
</head>
<body>

    <div class="register-card">
        <h2><i class="fas fa-user-plus"></i> Register Here</h2>

        <form action="process" method="post">
            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input type="text" name="name" class="form-control" placeholder="Enter Name" required>
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-user-circle"></i></span>
                <input type="text" name="username" class="form-control" placeholder="Enter Username" required>
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                <input type="text" name="mobile" class="form-control" placeholder="Enter Mobile Number" required>
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <input type="email" name="email" class="form-control" placeholder="Enter Email Address" required>
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
            </div>

            <button type="submit" class="btn btn-register w-100"><i class="fas fa-user-check"></i> Register</button>

            <p class="mt-3">
                Already have an account? <a href="../login.jsp" class="login-link">Login Here</a>
            </p>
        </form>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
