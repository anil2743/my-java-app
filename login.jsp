<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CYE Technology Private Limited</title>
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/login.css">
  <style>
    .error-message {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Left Panel -->
    <div class="left-panel">
      <img src="images/login.jpg" class="login_img" alt="Login Image">
    <p>Sign in to your account <a href="https://www.cyetechnology.com" target="_blank" style="text-decoration:none; color: linear-gradient(135deg, #2575fc, #6a11cb);">www.cyetechnology.com</a></p>
    </div>

    <!-- Right Panel -->
    <div class="right-panel">
      <h2>Hello! <span>Login Your Account</span></h2>
      <h5 class="mb-4"></h5>
      
      <!-- Error/Success Messages -->
      <% if (request.getParameter("error") != null) { %>
          <p id="error-message" class="error-message">Invalid email or password</p>
      <% } %>
      <% if (request.getParameter("success") != null) { %>
          <p class="error-message" style="color: #27ae60;">Password changed successfully!</p>
      <% } %>

      <form action="login" method="post"> <!-- Adjust action as needed -->
        <input type="email" class="form-control" name="email" placeholder="Email Address" required>
        <input type="password" class="form-control" name="password" placeholder="Password" required>

       
        <button type="submit" class="btn btn-custom mt-3">Sign In</button>

        <div class="create-account">
          <a href="register.jsp">Create Account</a> <!-- Updated to .jsp -->
        </div>
      </form>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Hide the error message after 3 seconds
    setTimeout(function() {
      var errorMessage = document.getElementById("error-message");
      if (errorMessage) {
        errorMessage.style.display = "none";
      }
    }, 3000); // 3000 milliseconds = 3 seconds
  </script>
</body>
</html>