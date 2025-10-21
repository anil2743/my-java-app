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

@WebServlet(value = "/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/exam";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Anilp@2024";

    public AdminRegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check for existing Admin_ID or Email
            String checkQuery = "SELECT COUNT(*) FROM admin WHERE Admin_ID = ? OR Email = ?";
            checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, adminId);
            checkStmt.setString(2, email);
            rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                request.setAttribute("errorMessage", "Admin ID or Email already registered!");
                request.getRequestDispatcher("admin_register.jsp").forward(request, response);
                return;
            }

            // Insert new admin record
            String insertQuery = "INSERT INTO admin (Admin_ID, Name, Email, Password, Role, Last_Login, Account_Created) VALUES (?, ?, ?, ?, ?, NOW(), CURDATE())";
            insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, adminId);
            insertStmt.setString(2, name);
            insertStmt.setString(3, email);
            insertStmt.setString(4, hashedPassword);
            insertStmt.setString(5, role);
            int rowsAffected = insertStmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("adminlogin.jsp");
            } else {
                request.setAttribute("errorMessage", "Registration failed!");
                request.getRequestDispatcher("admin_register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("admin_register.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (insertStmt != null) insertStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}