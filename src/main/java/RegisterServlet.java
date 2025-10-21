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
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(value = "/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/exam";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Anilp@2024";

    public RegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String batch = request.getParameter("batch");
        String exam = request.getParameter("exam");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        Connection conn = null;
        PreparedStatement checkEmployeeStmt = null;
        PreparedStatement checkDuplicateStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if employee ID exists in employee_ids table
            String checkEmployeeQuery = "SELECT COUNT(*) FROM employee_ids WHERE employee_id = ?";
            checkEmployeeStmt = conn.prepareStatement(checkEmployeeQuery);
            checkEmployeeStmt.setString(1, id);
            rs = checkEmployeeStmt.executeQuery();
            rs.next();
            if (rs.getInt(1) == 0) {
                request.setAttribute("errorMessage", "Employee ID not registered in company");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check for duplicate employee ID in employee_registrations table
            String checkDuplicateQuery = "SELECT COUNT(*) FROM employee_registrations WHERE ID = ?";
            checkDuplicateStmt = conn.prepareStatement(checkDuplicateQuery);
            checkDuplicateStmt.setString(1, id);
            rs = checkDuplicateStmt.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                request.setAttribute("errorMessage", "Employee ID already registered!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Insert registration details
            String insertQuery = "INSERT INTO employee_registrations (ID, Name, email, Password, Batch, Exam) VALUES (?, ?, ?, ?, ?, ?)";
            insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, id);
            insertStmt.setString(2, name);
            insertStmt.setString(3, email);
            insertStmt.setString(4, hashedPassword);
            insertStmt.setString(5, batch);
            insertStmt.setString(6, exam);
            int rowsAffected = insertStmt.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("successMessage", "Registered successfully");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (checkEmployeeStmt != null) checkEmployeeStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (checkDuplicateStmt != null) checkDuplicateStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (insertStmt != null) insertStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}