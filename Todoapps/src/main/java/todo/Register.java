package todo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String dob = req.getParameter("dob");
        String email = req.getParameter("email");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");
            
            PreparedStatement ps = con.prepareStatement("INSERT INTO register (username, password, first_name, last_name, dob, email) VALUES (?, ?, ?, ?, ?, ?)");
            
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, firstName);
            ps.setString(4, lastName);
            ps.setString(5, dob);
            ps.setString(6, email);
            int count = ps.executeUpdate();
            if (count > 0) {
                res.setContentType("text/html");
                RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
                rd.include(req, res);
            } else {
                res.setContentType("text/html");
                out.print("<h3>Registration Failed</h3>");
                RequestDispatcher rd = req.getRequestDispatcher("/register.jsp");
                rd.include(req, res);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            
            res.setContentType("text/html");
            out.print("<h3>Exception occurred: " + e.getMessage() + "</h3>");
            
            RequestDispatcher rd = req.getRequestDispatcher("/register.jsp");
            rd.include(req, res);
        }
    }
}
