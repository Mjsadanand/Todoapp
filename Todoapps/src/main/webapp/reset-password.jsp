<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Password</h2>
    <form action="ResetPassword" method="post">
        <input type="hidden" name="token" value="<%= request.getParameter("token") %>">
        <label>New Password:</label>
        <input type="password" name="password" required>
        <button type="submit">Reset</button>
    </form>
</body>
</html>
