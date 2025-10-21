<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/exam?useSSL=false&serverTimezone=Asia/Kolkata";
    String username = "root";
    String password = "Anilp@2024";
    String errorMessage = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        String query = "SELECT ID, Name, email, Exam, status, Batch, DATE(Registration_DateTime) AS RegDate, Attempts FROM employee_registrations";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<tr><td colspan='8'>No data found in employee_registrations table.</td></tr>");
        }
    } catch (Exception e) {
        errorMessage = "Error initializing data: " + e.getMessage();
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/RegistrationDetails.css">
</head>
<body>
    <div class="registrations">
        <header>
            <h1>Employee Registrations</h1>
        </header>
        <div class="filters">
            <div class="filter-group">
                <label>Batch Filter</label>
                <input type="text" id="batchFilter" placeholder="Search batch...">
            </div>
            <div class="filter-group">
                <label>Date Filter</label>
                <input type="date" id="dateFilter">
            </div>
            <div class="filter-group">
                <label>Status Filter</label>
                <select id="statusFilter">
                    <option value="">All Statuses</option>
                    <option value="Pending">Pending</option>
                    <option value="Assigned">Assigned</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Submitted">Submitted</option>
                    <option value="Pass">Pass</option>
                    <option value="Fail">Fail</option>
                </select>
            </div>
            <div class="filter-group">
                <label>Employee ID Search</label>
                <input type="text" id="empIdSearch" placeholder="Search Employee ID...">
            </div>
        </div>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Exam</th>
                        <th>Status</th>
                        <th>Batch</th>
                        <th>Date</th>
                        <th>Attempts</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            while (rs != null && rs.next()) {
                                String id = rs.getString("ID");
                                String name = rs.getString("Name");
                                String empEmail = rs.getString("email"); // Renamed to avoid conflict
                                String exam = rs.getString("Exam");
                                String status = rs.getString("status");
                                String batch = rs.getString("Batch");
                                String date = rs.getString("RegDate");
                                int attempts = rs.getInt("Attempts");

                                id = (id != null) ? id : "N/A";
                                name = (name != null) ? name : "N/A";
                                empEmail = (empEmail != null) ? empEmail : "N/A";
                                exam = (exam != null) ? exam : "N/A";
                                status = (status != null) ? status : "N/A";
                                batch = (batch != null) ? batch : "N/A";
                                date = (date != null) ? date : "N/A";
                                if (rs.wasNull()) {
                                    attempts = 0; // Handle null case for Attempts
                                }
                                System.out.println("Employee ID: " + id + ", Attempts: " + attempts);
                    %>
                    <tr data-id="<%= id.toLowerCase() %>" data-name="<%= name %>" data-email="<%= empEmail %>"
                        data-exam="<%= exam %>" data-status="<%= status %>" data-batch="<%= batch %>"
                        data-date="<%= date %>" data-attempts="<%= attempts %>">
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= empEmail %></td>
                        <td><%= exam %></td>
                        <td><%= status %></td>
                        <td><%= batch %></td>
                        <td><%= date %></td>
                        <td><%= attempts %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            errorMessage = "Error fetching data: " + e.getMessage();
                            out.println("<tr><td colspan='8'>" + errorMessage + "</td></tr>");
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <% if (errorMessage != null) { %>
        <div class="error-message"><%= errorMessage %></div>
        <% } %>
    </div>
    <script src="js/RegistrationDetails.js"></script>
</body>
</html>