import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;



@WebServlet(value = "/adminLogin")
public class AdminLogin extends HttpServlet {
    private static final String URL = "jdbc:mysql://localhost:3306/exam";
    private static final String USER = "root";
    private static final String PASS = "Anilp@2024";

    public AdminLogin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            String adminQuery = "SELECT * FROM admin WHERE Email = ?";
            ps = conn.prepareStatement(adminQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("Password");
                if (BCrypt.checkpw(password, storedPassword)) {
                    HttpSession oldSession = UserSessionManager.getSession(email);
                    if (oldSession != null) {
                        try {
                            oldSession.invalidate();
                        } catch (IllegalStateException e) {
                            // Handle exception silently
                        }
                    }

                    HttpSession session = request.getSession(true);
                    session.setAttribute("email", email);
                    UserSessionManager.registerSession(email, session);
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.sendRedirect("adminlogin.jsp?error=1");
                }
            } else {
                response.sendRedirect("adminlogin.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminlogin.jsp?error=2");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("adminlogin.jsp");
    }
}