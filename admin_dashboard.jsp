<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.Base64" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }

    String adminName = "";
    String adminEmail = "";
    byte[] profilePhotoBytes = null;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam?useSSL=false&serverTimezone=Asia/Kolkata", "root", "Anilp@2024");
        
        String sql = "SELECT Name, Email, Profile_Photo FROM admin WHERE Email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            adminName = rs.getString("Name");
            adminEmail = rs.getString("Email");
            Blob profilePhoto = rs.getBlob("Profile_Photo");
            if (profilePhoto != null) {
                profilePhotoBytes = profilePhoto.getBytes(1, (int) profilePhoto.length());
            }
        } else {
            adminName = "Unknown Admin";
            adminEmail = "N/A";
        }
    } catch (Exception e) {
        e.printStackTrace();
        adminName = "Error";
        adminEmail = "Error fetching data";
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erripuku technology Private Limited</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/admin_styles.css">
</head>
<body>
    <div class="dashboard">
        <!-- Sidebar (Left) -->
        <div class="sidebar">
            <div class="sidebar-header">
                <img src="<%= profilePhotoBytes != null ? "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profilePhotoBytes) : "images/default_profile.jpg" %>" 
                     alt="Profile Photo" class="sidebar-photo">
                <h2 class="sidebar-title">Admin Panel</h2>
            </div>
            <div class="nav-container">
                <ul class="nav-list">
                    <li class="nav-item" onclick="loadIframe('admin_profile.jsp')"><i class="fas fa-user"></i> Admin Profile</li>    
                   <!--   <li class="nav-item" onclick="loadIframe('exam_overview.jsp')"><i class="fas fa-chart-bar"></i> Exam Overview</li>  -->
                    <li class="nav-item" onclick="loadIframe('exam_creation.jsp')"><i class="fas fa-edit"></i> Exam Creation & Assignment</li>
                    <li class="nav-item" onclick="loadIframe('assigned_exams.jsp')"><i class="fas fa-tasks"></i> Assigned Exams</li>
                    <li class="nav-item" onclick="loadIframe('employee_registrations.jsp')"><i class="fas fa-users"></i> Employee Registrations</li>
                    <li class="nav-item" onclick="loadIframe('results_summary.jsp')"><i class="fas fa-poll"></i> Results Summary</li>
                    <li class="nav-item" onclick="loadIframe('employee_ids.jsp')"><i class="fas fa-id-card"></i> Employee IDs</li>
                    <!-- Logout Item -->
                    <li class="nav-item" onclick="logoutUser()"><i class="fas fa-sign-out-alt"></i> Logout</li>
                </ul>
            </div>
        </div>

        <!-- Main Content (Right) -->
        <div class="main-content" id="mainContent">
            <!-- Welcome Message (Center on Load) -->
            <div class="welcome-message" id="welcomeMessage">
                <div class="welcome-card">
                    <h1>Welcome, <%= adminName %>!</h1>
                    <p class="tagline">Empower Your Team with Seamless Exam Management</p>
                    <div class="welcome-info">
                        <span><i class="fas fa-envelope"></i> <%= adminEmail %></span>
                        <span><i class="fas fa-user-shield"></i> Administrator</span>
                    </div>
                </div>
            </div>

            <!-- Inline Content Area (Empty) -->
            <div class="content-area" id="contentArea">
                <div id="inlineSections">
                    <!-- No inline admin profile section -->
                </div>
            </div>

            <!-- Iframe for Full Right Side -->
            <iframe id="contentIframe" class="content-iframe" frameborder="0"></iframe>
        </div>
    </div>
    <script src="js/admin_scripts.js"></script>
    <script>
        function logoutUser() {
            // Create a form dynamically and submit it to LogoutServlet
            var form = document.createElement('form');
            form.method = 'post';
            form.action = '<%= request.getContextPath() %>/AdminLogout';
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>