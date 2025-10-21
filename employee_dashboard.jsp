<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="css/employee_all.css">
    <script>
        function loadContent(url) {
            document.getElementById('contentFrame').src = url;
            document.getElementById('welcomeBox').style.display = 'none';
        }
        function openFullscreen(url) {
            document.querySelector('.navbar').style.display = 'none';
            document.querySelector('.content').style.marginLeft = '0';
            document.querySelector('.content').style.width = '100%';
            document.getElementById('contentFrame').src = url;
            document.getElementById('contentFrame').requestFullscreen();
        }
        function logoutUser() {
            var form = document.createElement('form');
            form.method = 'post';
            form.action = '<%= request.getContextPath() %>/EmployeeLogoutServlet';
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    <%
        String email = (String) session.getAttribute("email");
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String profilePhotoSrc = "images/default_profile.jpg"; // Default image
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "Anilp@2024");
            
            String sql = "SELECT Profile_Photo FROM employee_registrations WHERE email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Blob profilePhoto = rs.getBlob("Profile_Photo");
                if (profilePhoto != null) {
                    byte[] profilePhotoBytes = profilePhoto.getBytes(1, (int) profilePhoto.length());
                    profilePhotoSrc = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profilePhotoBytes);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <!-- Left Navigation Bar -->
    <div class="navbar">
        <div class="navbar-header">
            <img src="<%= profilePhotoSrc %>" alt="Profile">
            <h2>Dashboard</h2>
        </div>
        <a href="#" onclick="loadContent('profile.jsp')"><i class="fas fa-user"></i> Employee Profile</a>
        <a href="#" onclick="loadContent('assessments.jsp')"><i class="fas fa-tasks"></i> Assessments</a>
        <a href="#" onclick="loadContent('results.jsp')"><i class="fas fa-poll"></i> Results</a>
        <!-- Logout Link -->
        <a href="#" onclick="logoutUser()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- Right Content Area -->
    <div class="content">
        <iframe id="contentFrame" name="contentFrame"></iframe>

        <!-- Default Welcome Message -->
        <div class="welcome-box" id="welcomeBox">
            <div class="welcome-message">
                Welcome, <%= email %>!
            </div>
        </div>
    </div>
</body>
</html>