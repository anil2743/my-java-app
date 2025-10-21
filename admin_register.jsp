<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="css/admin_register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="register-container">
        <div class="form-card">
            <div class="form-header">
                <h2><i class="fas fa-user-shield"></i> Admin Registration</h2>
            </div>
            <form action="AdminRegisterServlet" method="post" onsubmit="return validatePassword()">
                <div class="form-group">
                    <label for="adminId"><i class="fas fa-id-card"></i> Admin ID</label>
                    <input type="text" id="adminId" name="adminId" required>
                </div>
                <div class="form-group">
                    <label for="name"><i class="fas fa-user"></i> Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email ID</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <input type="password" id="password" name="password" required>
                    <span class="password-hint" id="password-hint">Password must be 6-15 characters, with at least 1 uppercase, 1 number, and 1 symbol.</span>
                </div>
                <div class="form-group">
                    <label for="role"><i class="fas fa-user-tag"></i> Role</label>
                    <input type="text" id="role" name="role" value="admin" readonly>
                </div>
                <button type="submit" class="register-btn"><i class="fas fa-check"></i> Register</button>
                <button type="button" class="login-btn" onclick="window.location.href='adminlogin.jsp'"><i class="fas fa-sign-in-alt"></i> Back to Login</button>
            </form>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        const passwordInput = document.getElementById("password");
        const passwordHint = document.getElementById("password-hint");

        passwordInput.addEventListener("input", function() {
            const password = this.value;
            const isValid = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,15}$/.test(password);
            passwordHint.style.display = isValid ? "none" : "block";
        });

        function validatePassword() {
            const password = passwordInput.value;
            const isValid = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,15}$/.test(password);
            if (!isValid) {
                passwordHint.style.display = "block";
                return false;
            }
            return true;
        }
    </script>
</body>
</html>