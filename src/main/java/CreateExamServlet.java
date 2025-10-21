import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@WebServlet(value = "/CreateExamServlet")
public class CreateExamServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/exam?useSSL=false&serverTimezone=Asia/Kolkata";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Anilp@2024";
    private static final ZoneId IST_ZONE = ZoneId.of("Asia/Kolkata");

    public CreateExamServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String examType = request.getParameter("examType");
        String batchAssignment = request.getParameter("batchAssignment");
        String dueDateStr = request.getParameter("dueDate");
        String dueTimeStr = request.getParameter("dueTime");

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);
            log("Database connection established");

            LocalDateTime currentDateTime = LocalDateTime.now(IST_ZONE);
            LocalDateTime dueLocalDateTime = LocalDateTime.parse(dueDateStr + "T" + dueTimeStr, 
                                                                DateTimeFormatter.ISO_LOCAL_DATE_TIME);
            Timestamp dueTimestamp = Timestamp.valueOf(dueLocalDateTime);
            log("Parsed Deadline: " + dueLocalDateTime + " (Current IST: " + currentDateTime + ")");

            if (dueLocalDateTime.isBefore(currentDateTime)) {
                request.setAttribute("error", "Cannot assign '" + examType + "': Deadline is in the past.");
                request.getRequestDispatcher("exam_creation.jsp").forward(request, response);
                return;
            }

            // Check for existing active deadlines
            String checkSql = "SELECT Deadline_Date FROM exam_creation_assignment WHERE Exam_Name = ? AND Assign_To = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, examType);
            checkStmt.setString(2, batchAssignment);
            rs = checkStmt.executeQuery();

            boolean hasActiveDeadline = false;
            while (rs.next()) {
                LocalDateTime existingDeadline = rs.getTimestamp("Deadline_Date").toLocalDateTime();
                log("Existing Deadline for " + examType + " in " + batchAssignment + ": " + existingDeadline);
                if (existingDeadline.isAfter(currentDateTime)) {
                    hasActiveDeadline = true;
                    break;
                }
            }

            if (hasActiveDeadline) {
                request.setAttribute("error", "Cannot assign '" + examType + "' to '" + batchAssignment + "': An active deadline exists.");
            } else {
                // Insert new exam assignment
                String insertSql = "INSERT INTO exam_creation_assignment (Exam_Name, Assign_To, Deadline_Date) VALUES (?, ?, ?)";
                insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, examType);
                insertStmt.setString(2, batchAssignment);
                insertStmt.setTimestamp(3, dueTimestamp);
                log("Executing SQL: " + insertStmt.toString());
                int rowsAffected = insertStmt.executeUpdate();
                log("Rows affected: " + rowsAffected);

                if (rowsAffected > 0) {
                    // Update employee attempts
                    String updateSql = "UPDATE employee_registrations SET Attempts = COALESCE(Attempts, 0) + 1 WHERE Batch = ? AND Status IN ('Fail', 'Pending')";
                    updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setString(1, batchAssignment);
                    log("Executing SQL: " + updateStmt.toString());
                    int updatedRows = updateStmt.executeUpdate();
                    log("Updated Attempts for " + updatedRows + " employees in batch " + batchAssignment);

                    conn.commit();
                    request.setAttribute("success", true);
                } else {
                    conn.rollback();
                    request.setAttribute("error", "Failed to insert exam: No rows affected.");
                }
            }
        } catch (ClassNotFoundException e) {
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
            log("Driver Error: " + e.getMessage(), e);
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                log("Rollback failed: " + ex.getMessage());
            }
            request.setAttribute("error", "Database error: " + e.getMessage() + " (SQL State: " + e.getSQLState() + ")");
            log("SQL Error: " + e.getMessage() + " (SQL State: " + e.getSQLState() + ")", e);
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                log("Rollback failed: " + ex.getMessage());
            }
            request.setAttribute("error", "Invalid date/time format: " + e.getMessage());
            log("Error: " + e.getMessage(), e);
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (SQLException e) {
                log("Error closing ResultSet: " + e.getMessage());
            }
            try {
                if (checkStmt != null) checkStmt.close();
            } catch (SQLException e) {
                log("Error closing checkStmt: " + e.getMessage());
            }
            try {
                if (insertStmt != null) insertStmt.close();
            } catch (SQLException e) {
                log("Error closing insertStmt: " + e.getMessage());
            }
            try {
                if (updateStmt != null) updateStmt.close();
            } catch (SQLException e) {
                log("Error closing updateStmt: " + e.getMessage());
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                log("Error closing connection: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("exam_creation.jsp").forward(request, response);
    }
}