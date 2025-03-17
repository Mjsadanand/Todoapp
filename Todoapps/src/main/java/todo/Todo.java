package todo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Todo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String action = req.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");

            if ("delete".equals(action)) {
                int taskId = Integer.parseInt(req.getParameter("taskId"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM tasks WHERE id = ? AND username = ?");
                ps.setInt(1, taskId);
                ps.setString(2, username);
                ps.executeUpdate();
                res.sendRedirect("todo.jsp"); 
                return;
            }


        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Exception occurred: " + e.getMessage() + "</h3>");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String action = req.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");

            if ("add".equals(action)) {
                String topic = req.getParameter("topic");
                String content = req.getParameter("content");
                String time = req.getParameter("time");
                String status = req.getParameter("status");

                PreparedStatement ps = con.prepareStatement("INSERT INTO tasks (username, topic, content, time, status) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, username);
                ps.setString(2, topic);
                ps.setString(3, content);
                ps.setString(4, time);
                ps.setString(5, status);
                int rowsAffected = ps.executeUpdate();
                System.out.println("Rows Inserted: " + rowsAffected);
                res.sendRedirect("todo.jsp");

            } 
            else if ("update".equals(action)) {
                int taskId = Integer.parseInt(req.getParameter("taskId"));
                String content = req.getParameter("content");
                String status = req.getParameter("status");

                PreparedStatement ps = con.prepareStatement("UPDATE tasks SET content = ?, status = ? WHERE id = ? AND username = ?");
                ps.setString(1, content);
                ps.setString(2, status);
                ps.setInt(3, taskId);
                ps.setString(4, username);
                ps.executeUpdate();
                res.sendRedirect("todo.jsp");
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
