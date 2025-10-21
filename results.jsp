<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="css/results.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="results-container">
        <div class="results-header">
            <h1><i class="fas fa-chart-bar"></i> Exam Results</h1>
        </div>
        <div class="results-content">
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
                boolean showResults = false;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

                    // Fetch batch from employee_registrations
                    String batchSql = "SELECT Batch FROM employee_registrations WHERE email = ?";
                    stmt = conn.prepareStatement(batchSql);
                    stmt.setString(1, email);
                    rs = stmt.executeQuery();
                    String batch = "";
                    if (rs.next()) {
                        batch = rs.getString("Batch");
                    }

                    // Check if Actions is "Completed" in assigned_exams
                    String actionSql = "SELECT Actions FROM assigned_exams WHERE Batch_Name = ? AND Actions = 'Completed'";
                    stmt = conn.prepareStatement(actionSql);
                    stmt.setString(1, batch);
                    rs = stmt.executeQuery();
                    if (rs.next()) {
                        showResults = true;
                    }

                    if (showResults) {
                        // Fetch results from employee_registrations
                        String resultsSql = "SELECT Score, Percentage, Exam, Attempts, Status FROM employee_registrations WHERE email = ?";
                        stmt = conn.prepareStatement(resultsSql);
                        stmt.setString(1, email);
                        rs = stmt.executeQuery();
            %>
                        <div class="results-card">
                            <% 
                                if (rs.next()) {
                                    String exam = rs.getString("Exam") != null ? rs.getString("Exam") : "N/A";
                                    String score = rs.getString("Score") != null ? rs.getString("Score") : "N/A"; // Treat as string
                                    String percentage = rs.getString("Percentage") != null ? rs.getString("Percentage") : "N/A"; // Treat as string
                                    int attempts = rs.getInt("Attempts"); // Attempts remains int
                                    String status = rs.getString("Status") != null ? rs.getString("Status") : "N/A";
                            %>
                                <div class="result-box slide-in">
                                    <i class="fas fa-book"></i>
                                    <h3>Exam</h3>
                                    <p><%= exam %></p>
                                </div>
                                <div class="result-box slide-in">
                                    <i class="fas fa-trophy"></i>
                                    <h3>Score</h3>
                                    <p><%= score %></p>
                                </div>
                                <div class="result-box slide-in">
                                    <i class="fas fa-percentage"></i>
                                    <h3>Percentage</h3>
                                    <p><%= percentage %></p>
                                </div>
                                <div class="result-box slide-in">
                                    <i class="fas fa-redo"></i>
                                    <h3>Attempts</h3>
                                    <p><%= attempts %></p>
                                </div>
                                <div class="result-box slide-in">
                                    <i class="fas fa-check-circle"></i>
                                    <h3>Status</h3>
                                    <p><%= status %></p>
                                </div>
                            <% 
                                } else {
                                    out.println("<p>No results found.</p>");
                                }
                            %>
                        </div>
            <%
                    } else {
            %>
                        <div class="results-card">
                            <h3>No Results Available</h3>
                            <p>Results will be displayed once your exam is completed.</p>
                        </div>
            <%
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
        </div>
    </div>
</body>
</html>