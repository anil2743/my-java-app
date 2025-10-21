<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="css/login_forgot.css">
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <h2>Forgot Password</h2>
        </div>
        <form id="forgotForm" action="ForgotPasswordServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group" id="otp-group" style="display: <%= request.getAttribute("otpSent") != null ? "block" : "none" %>;">
                <label for="otp">Enter OTP:</label>
                <input type="text" id="otp" name="otp">
            </div>
            <div class="form-group" id="password-group" style="display: <%= request.getAttribute("otpVerified") != null ? "block" : "none" %>;">
                <label for="new-password">New Password:</label>
                <input type="password" id="new-password" name="new-password">
                <span class="password-hint" id="password-hint">Password must be 6-15 characters, with at least 1 uppercase, 1 number, and 1 symbol.</span>
            </div>
            <div class="form-group" id="confirm-group" style="display: <%= request.getAttribute("otpVerified") != null ? "block" : "none" %>;">
                <label for="confirm-password">Confirm Password:</label>
                <input type="password" id="confirm-password" name="confirm-password">
            </div>
            <button type="submit" id="submit-btn">Submit</button>
        </form>
        <div class="error-message" id="message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
        </div>
    </div>

    <script type="text/javascript">
        const emailInput = document.getElementById("email");
        const otpInput = document.getElementById("otp");
        const newPasswordInput = document.getElementById("new-password");
        const confirmPasswordInput = document.getElementById("confirm-password");
        const passwordHint = document.getElementById("password-hint");

        newPasswordInput?.addEventListener("input", function() {
            const password = this.value;
            const isValid = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,15}$/.test(password);
            passwordHint.style.display = isValid ? "none" : "block";
        });

        function validateForm() {
            const otpGroup = document.getElementById("otp-group").style.display;
            const passwordGroup = document.getElementById("password-group").style.display;

            if (otpGroup === "none") {
                return true; // Email submission
            } else if (passwordGroup === "none") {
                return otpInput.value.trim() !== ""; // OTP submission
            } else {
                const password = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                const isValid = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,15}$/.test(password);
                
                if (!isValid) {
                    passwordHint.style.display = "block";
                    return false;
                }
                if (password !== confirmPassword) {
                    document.getElementById("message").innerText = "Passwords do not match!";
                    return false;
                }
                return true;
            }
        }
    </script>
</body>
</html>