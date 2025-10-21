<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">		
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CYE Technology Private Limited</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/register.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        .popup-message {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            padding: 10px 20px;
            color: #fff;
            font-size: 1rem;
            border-radius: 5px;
            z-index: 1000;
            display: none;
        }
        .success {
            color: green; /* Green text */
            background: none; /* No background */
        }
        .error {
            color: red; /* Red text */
            background: none; /* No background */
        }
    </style>
</head>
<body>
    <div class="body-wrapper">
        <div class="container">
            <!-- Left Panel -->
            <div class="left-panel">
                <img src="images/login.jpg" class="login_img" alt="Login Image">
                 <p>Sign up to your account <a href="https://www.cyetechnology.com" target="_blank" style="text-decoration:none; color: linear-gradient(135deg, #2575fc, #6a11cb);">www.cyetechnology.com</a></p>
    </div>

            <!-- Right Panel -->
            <div class="right-panel">
                <h2>Sign Up</h2>
                <h5 class="mb-4"></h5>
                <form action="register" method="post" id="registerForm" onsubmit="return validatePassword()">
                    <input type="text" class="underline-input" id="id" name="id" placeholder="Employee ID" required>
                    <input type="text" class="underline-input" id="name" name="name" placeholder="Your Name" required>
                    <input type="email" class="underline-input" id="email" name="email" placeholder="Email Address" required>
                    <input type="password" class="underline-input" id="password" name="password" placeholder="Password" required>
                    <span class="password-hint" id="password-hint">Password must be 6-15 characters, with at least 1 uppercase, 1 number, and 1 symbol.</span>
                    
                    <div class="form-group">
                        <input type="text" class="underline-input" id="batch-search" placeholder="Search Batch Year (e.g., 2025 or 25)" required>
                        <select class="underline-input" id="batch" name="batch" required>
                            <option value="">Select Batch</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <select class="underline-input" id="exam" name="exam" required>
                            <option value="">Select Exam</option>
                            <option value="fullstack">Fullstack</option>
                            <option value="cyber">Cyber</option>
                            <option value="python">Python</option>
                            <option value="aws">AWS</option>
                            <option value="frontend">Frontend</option>
                            <option value="database">Database</option>
                            <option value="java">Java</option>
                            <option value="mern">MERN</option>
                        </select>
                    </div>

                    <!-- Register button -->
                    <button type="submit" class="btn btn-custom" style="padding: 8px 16px; font-size: 0.9rem;">
                        <i class="fas fa-check"></i> Register
                    </button>
                </form>
                
                <!-- Sign In button on right side -->
                <button type="button" onclick="window.location.href='login.jsp'" style="border: none; background: none; padding: 0; margin-top: 0px; margin-left: auto; display: block;">
                    <span style="background: linear-gradient(135deg, #2575fc, #6a11cb); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </span>
                </button>
                
                <div class="error-message">
                    <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
                </div>
            </div>
        </div>
    </div>

    <!-- Popup Message -->
    <div id="popup" class="popup-message"></div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JavaScript -->
    <script type="text/javascript">
        const batchSearch = document.getElementById("batch-search");
        const batchSelect = document.getElementById("batch");
        const passwordInput = document.getElementById("password");
        const passwordHint = document.getElementById("password-hint");

        // Debounce function to prevent rapid input skipping
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        // Batch search handler
        const updateBatchOptions = debounce(function() {
            const input = batchSearch.value.trim();
            batchSelect.innerHTML = '<option value="">Select Batch</option>'; // Reset options
            if (input.length >= 2) { // Only process if input is at least 2 characters
                let year = input;
                if (year.length === 2 && /^\d{2}$/.test(year)) {
                    year = "20" + year;
                }
                if (/^\d{4}$/.test(year)) {
                    for (let i = 65; i <= 90; i++) { // A to Z
                        const batch = "Batch " + year + "-" + String.fromCharCode(i);
                        const option = document.createElement("option");
                        option.value = batch;
                        option.textContent = batch;
                        batchSelect.appendChild(option);
                    }
                }
            }
        }, 300); // 300ms debounce delay

        batchSearch.addEventListener("input", updateBatchOptions);

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

        // Popup message function
        function showPopup(message, type) {
            const popup = document.getElementById("popup");
            popup.textContent = message;
            popup.className = "popup-message " + type; // Add success or error class
            popup.style.display = "block";
            setTimeout(() => {
                popup.style.display = "none";
                if (type === "success") {
                    window.location.href = "login.jsp"; // Redirect after 3 seconds
                }
            }, 3000); // Hide after 3 seconds
        }

        // Check if there's a success or error message from the servlet
        <% if (request.getAttribute("successMessage") != null) { %>
            showPopup("<%= request.getAttribute("successMessage") %>", "success");
        <% } else if (request.getAttribute("errorMessage") != null) { %>
            showPopup("<%= request.getAttribute("errorMessage") %>", "error");
        <% } %>
    </script>
</body>
</html>