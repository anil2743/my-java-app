<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/exam?useSSL=false&serverTimezone=Asia/Kolkata";
    String username = "root";
    String password = "Anilp@2024";
    String message = null;
    String messageColor = "red";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String employeeId = request.getParameter("employeeId");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // Check if employee ID already exists
            String checkSql = "SELECT COUNT(*) FROM employee_ids WHERE employee_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, employeeId);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close();

            if (count > 0) {
                message = "Employee ID already exists!";
            } else {
                // Insert new employee ID
                String insertSql = "INSERT INTO employee_ids (employee_id) VALUES (?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, employeeId);
                pstmt.executeUpdate();
                message = "Employee ID added successfully!";
                messageColor = "green";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }

    // Fetch all employee IDs
    List<String> employeeIds = new ArrayList<>();
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT employee_id FROM employee_ids ORDER BY employee_id");

        while (rs.next()) {
            employeeIds.add(rs.getString("employee_id"));
        }
    } catch (Exception e) {
        message = "Error fetching employee IDs: " + e.getMessage();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/employee_ids_styles.css">
</head>
<body>
    <div class="employee-ids-container">
        <h1>Employee IDs</h1>
        <div class="employee-ids-form">
            <form method="POST">
                <input type="text" name="employeeId" placeholder="Enter Employee ID" required>
                <button type="submit">Submit</button>
            </form>
        </div>
        <% if (message != null) { %>
        <div class="message" style="color: <%= messageColor %>;"><%= message %></div>
        <% } %>
        <div class="employee-ids-list">
            <input type="text" id="filterInput" placeholder="Filter Employee IDs">
            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String id : employeeIds) { %>
                    <tr>
                        <td><%= id %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <script src="js/employee_ids_scripts.js"></script>
</body>
</html>