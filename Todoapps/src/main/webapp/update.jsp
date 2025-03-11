<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
HttpSession session1 = request.getSession(false);
if (session1 == null || session1.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String username = (String) session1.getAttribute("username");

// Validate taskId parameter
String taskIdParam = request.getParameter("taskId");
int taskId = -1;

if (taskIdParam != null && !taskIdParam.isEmpty()) {
	try {
		taskId = Integer.parseInt(taskIdParam);
	} catch (NumberFormatException e) {
		out.println("<h3>Invalid Task ID!</h3>");
		return;
	}
} else {
	out.println("<h3>Task ID is missing!</h3>");
	return;
}

// Database connection
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");
PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks WHERE id = ? AND username = ?");
ps.setInt(1, taskId);
ps.setString(2, username);
ResultSet rs = ps.executeQuery();

if (!rs.next()) {
	out.println("<h3>Task not found!</h3>");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Task</title>
<link rel="stylesheet" href="edit.css">
<script>
	function redirectToHome() {
		setTimeout(function() {
			window.location.href = "todo.jsp";
		}, 1000);
	}
</script>
<style type="text/css">
select {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: 2px solid #ccc;
	border-radius: 5px;
	background-color: #fff;
	cursor: pointer;
	transition: border-color 0.3s ease-in-out;
}

select:focus {
	border-color: #007bff;
	outline: none;
}

option {
	font-size: 16px;
	background-color: #fff;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Edit Task</h2>
		<form action="Todo" method="post" class="edit-form"
			onsubmit="redirectToHome()">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="taskId" value="<%=taskId%>"> <label>Topic:</label>
			<input type="text" name="topic" value="<%=rs.getString("topic")%>"
				readonly> <label>Content:</label> <input type="text"
				name="content" value="<%=rs.getString("content")%>" required>

			<label>Time:</label> <input type="datetime-local" name="time"
				value="<%=rs.getString("time")%>" > <label>Status:</label>

			<select name="status" value="<%=rs.getString("status")%>" required>
				<option value="" disabled selected>Select Status</option>
				<option value="pending">Pending</option>
				<option value="completed">Completed</option>
			</select>

			<button type="submit">Update Task</button>
		</form>
		<a href="todo.jsp" class="back-btn">Back to List</a>
	</div>
</body>
</html>
