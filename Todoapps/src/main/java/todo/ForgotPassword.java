import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ForgotPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        String email = req.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM register WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Generate reset token
                String token = UUID.randomUUID().toString();

                // Store token in DB
                PreparedStatement updatePs = con.prepareStatement("UPDATE register SET reset_token=? WHERE email=?");
                updatePs.setString(1, token);
                updatePs.setString(2, email);
                updatePs.executeUpdate();

                // Send email with reset link
                String resetLink = "http://localhost:8080/todo/reset-password.jsp?token=" + token;
                EmailUtility.sendEmail(email, "Password Reset Request", "Click here to reset your password: " + resetLink);

                out.print("<h3>Reset link has been sent to your email.</h3>");
            } else {
                out.print("<h3>Email not found.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<h3>Exception: " + e.getMessage() + "</h3>");
        }
    }
}
