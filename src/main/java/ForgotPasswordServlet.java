import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(value = "/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/exam?useSSL=false&serverTimezone=Asia/Kolkata";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Anilp@2024";
    private static final String EMAIL_FROM = "cyetechnology2025@gmail.com";
    private static final String SMTP_HOST = "smtp.mailtrap.io";
    private static final String SMTP_PORT = "2525";
    private static final String SMTP_USER = "your_mailtrap_username";
    private static final String SMTP_PASSWORD = "your_mailtrap_password";

    public ForgotPasswordServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        HttpSession session = request.getSession();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if (otp == null && newPassword == null) {
                // Step 1: Check if email exists and send OTP
                try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM employee_registrations WHERE email = ?")) {
                    ps.setString(1, email);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            String generatedOtp = String.format("%06d", new Random().nextInt(999999));
                            session.setAttribute("otp", generatedOtp);
                            session.setAttribute("email", email);

                            try {
                                sendOtpEmail(email, generatedOtp);
                                request.setAttribute("otpSent", true);
                                request.setAttribute("message", "OTP sent to registered email!");
                            } catch (MessagingException e) {
                                log("Failed to send OTP email: " + e.getMessage(), e);
                                request.setAttribute("message", "Failed to send OTP: " + e.getMessage());
                                request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
                                return;
                            }
                            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
                        } else {
                            request.setAttribute("message", "Email not found. Please register!");
                            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
                        }
                    }
                }
            } else if (newPassword == null) {
                // Step 2: Verify OTP
                String sessionOtp = (String) session.getAttribute("otp");
                if (sessionOtp != null && sessionOtp.equals(otp)) {
                    request.setAttribute("otpSent", true);
                    request.setAttribute("otpVerified", true);
                    request.setAttribute("message", "OTP verified. Enter new password.");
                    request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
                } else {
                    request.setAttribute("otpSent", true);
                    request.setAttribute("message", "Invalid OTP!");
                    request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
                }
            } else {
                // Step 3: Update password
                String sessionEmail = (String) session.getAttribute("email");
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                try (PreparedStatement ps = conn.prepareStatement("UPDATE employee_registrations SET Password = ? WHERE email = ?")) {
                    ps.setString(1, hashedPassword);
                    ps.setString(2, sessionEmail);
                    int rows = ps.executeUpdate();

                    if (rows > 0) {
                        session.invalidate();
                        response.sendRedirect("login.jsp?success=1");
                    } else {
                        request.setAttribute("otpSent", true);
                        request.setAttribute("otpVerified", true);
                        request.setAttribute("message", "Failed to update password! Email not found.");
                        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            log("Database error: " + e.getMessage(), e);
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
        } catch (Exception e) {
            log("Unexpected error: " + e.getMessage(), e);
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
        }
    }

    private void sendOtpEmail(String toEmail, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.debug", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected jakarta.mail.PasswordAuthentication getPasswordAuthentication() {
                return new jakarta.mail.PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EMAIL_FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Your OTP for Password Reset");
        message.setText("Your OTP is: " + otp + "\n\nUse this to reset your password.");
        Transport.send(message);
        log("OTP email sent successfully to: " + toEmail);
    }
}