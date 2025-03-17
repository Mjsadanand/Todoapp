package todo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ResetPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        String token = req.getParameter("token");
        String newPassword = req.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM register WHERE reset_token = ?");
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                PreparedStatement updatePs = con.prepareStatement("UPDATE register SET password=?, reset_token=NULL WHERE reset_token=?");
                updatePs.setString(1, newPassword);
                updatePs.setString(2, token);
                updatePs.executeUpdate();

                out.print("<h3>Password reset successful. <a href='login.jsp'>Login</a></h3>");
            } else {
                out.print("<h3>Invalid or expired token.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<h3>Exception: " + e.getMessage() + "</h3>");
        }
    }
}
