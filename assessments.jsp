<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="css/assessments.css">
    <script>
        function openFullscreen(url) {
            fetch('assessments.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'takeAssessment=true'
            })
            .then(response => {
                if (response.ok) {
                    let examWindow = window.open(url, '_blank', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,fullscreen=yes');
                    if (examWindow) {
                        examWindow.focus();
                        setTimeout(() => {
                            window.location.reload();
                        }, 500);
                    }
                } else {
                    throw new Error('Failed to update hasClicked');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to start the assessment. Please try again.');
            });
            return false;
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

        String DB_URL = "jdbc:mysql://localhost:3306/exam";
        String DB_USER = "root";
        String DB_PASS = "Anilp@2024";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String assessmentLink = "";
        boolean showLink = false;
        String hasClicked = "No";
        LocalDateTime currentDateTime = LocalDateTime.now();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Fetch employee details
            String sql = "SELECT status, Batch, Exam, hasClicked FROM employee_registrations WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");
                String batch = rs.getString("Batch");
                String examType = rs.getString("Exam");
                hasClicked = rs.getString("hasClicked") != null ? rs.getString("hasClicked") : "No"; // Default to "No" if null

                if ("Fail".equals(status) || "Pending".equals(status)) {
                    String assignedSql = "SELECT Deadline FROM assigned_exams WHERE Batch_Name = ? AND Actions = 'Running'";
                    stmt = conn.prepareStatement(assignedSql);
                    stmt.setString(1, batch);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        LocalDateTime deadline = rs.getTimestamp("Deadline").toLocalDateTime();

                        if (currentDateTime.isBefore(deadline)) {
                            if ("No".equals(hasClicked)) {
                                showLink = true;
                                assessmentLink = examType != null && !examType.trim().isEmpty() ? examType + ".jsp" : "fullstack.jsp";
                            }
                        } else {
                            // Deadline has passed, reset hasClicked to 'No'
                            String resetSql = "UPDATE employee_registrations SET hasClicked = 'No' WHERE email = ?";
                            stmt = conn.prepareStatement(resetSql);
                            stmt.setString(1, email);
                            int rowsAffected = stmt.executeUpdate();
                            if (rowsAffected > 0) {
                                hasClicked = "No"; // Update local variable only if DB update succeeds
                            } else {
                                out.println("<p class='error'>Failed to reset hasClicked in database.</p>");
                            }
                        }
                    } else {
                        // No running exams for this batch, ensure hasClicked is 'No'
                        String resetSql = "UPDATE employee_registrations SET hasClicked = 'No' WHERE email = ?";
                        stmt = conn.prepareStatement(resetSql);
                        stmt.setString(1, email);
                        int rowsAffected = stmt.executeUpdate();
                        if (rowsAffected > 0) {
                            hasClicked = "No";
                        }
                    }
                }
            } else {
                // No record found for this email, insert default record (optional)
                String insertSql = "INSERT INTO employee_registrations (email, status, hasClicked) VALUES (?, 'Pending', 'No') ON DUPLICATE KEY UPDATE hasClicked = 'No'";
                stmt = conn.prepareStatement(insertSql);
                stmt.setString(1, email);
                stmt.executeUpdate();
                hasClicked = "No";
            }

            // Handle the AJAX POST request for takeAssessment
            if ("true".equals(request.getParameter("takeAssessment"))) {
                String updateSql = "UPDATE employee_registrations SET hasClicked = 'Yes' WHERE email = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, email);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    hasClicked = "Yes";
                    showLink = false;
                    if ("POST".equals(request.getMethod())) {
                        response.setContentType("text/plain");
                        out.print("success");
                        return;
                    }
                } else {
                    out.println("<p class='error'>Failed to update hasClicked to Yes.</p>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <div class="assessment-container">
        <div class="assessment-header">
            <h1><i class="fas fa-tasks"></i> Assessments</h1>
        </div>
        <div class="assessment-content">
            <p class="intro-text">Available assessments will be displayed below:</p>

            <div class="assessment-card">
                <% if (showLink) { %>
                    <h3>Take Your Assessment</h3>
                    <p>Click below to start your exam.</p>
                    <a href="#" onclick="return openFullscreen('<%= request.getContextPath() %>/<%= assessmentLink %>')" class="assessment-btn">Take Assessment</a>
                <% } else { %>
                    <h3>No Assessments Available</h3>
                    <p>Check back later for available assessments.</p>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>