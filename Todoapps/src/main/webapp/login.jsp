<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Login</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: url('log.jpg') no-repeat center center fixed;
	background-size: cover;
	margin: 0;
	padding: 0;
	display: flex;
	align-items: center;
	min-height: 100vh;
}

.container, .login-container {
	background: rgba(255, 255, 255, 0.2); /* Glassy effect */
	backdrop-filter: blur(10px); /* Blur effect */
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
	padding: 30px;
	width: 400px;
	margin-left: 550px;
	border: 1px solid rgba(255, 255, 255, 0.3);
}

h2 {
	text-align: center;
	color: #000; /* White text for better contrast */
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: 600;
	color: #000;
}

input[type="text"], input[type="password"], input[type="email"], input[type="date"]
	{
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box;
	font-size: 16px;
	transition: border-color 0.3s;
}

input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus,
	input[type="date"]:focus {
	border-color: #3f51b5;
	outline: none;
}

.btn-submit, .login-btn {
	background-color: #3f51b5;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 12px 20px;
	font-size: 16px;
	cursor: pointer;
	width: 100%;
	margin-top: 10px;
	transition: background-color 0.3s;
}

.btn-submit:hover, .login-btn:hover {
	background-color: #303f9f;
}

.header-decoration {
	height: 5px;
	background: linear-gradient(to right, #3f51b5, #7986cb);
	width: 100%;
	border-radius: 5px;
	margin-bottom: 20px;
}

.login-footer {
	margin-top: 25px;
	text-align: center;
	font-size: 14px;
	color: #666;
}

.login-footer a {
	color: #3f51b5;
	text-decoration: none;
}

.login-footer a:hover {
	text-decoration: underline;
}

.login-header p {
	color: #f00;
}

.login-footer p {
	color: #fff;
}

.login-footer a {
	color: #f00;
}
</style>
</head>
<body>
	<div class="login-container">

		<div class="login-header">
			<h2>Student Login</h2>
			<p>Enter your credentials to access your account</p>
		</div>

		<form action="login" method="post">
			<div class="form-group">
				<input type="text" id="username" name="username"
					placeholder="Enter your username" required>
			</div>

			<div class="form-group">
				<input type="password" id="password" name="password"
					placeholder="Enter your password" required>
			</div>

			<button type="submit" class="login-btn">Login</button>
		</form>

		<div class="login-footer">
			<p>
				Don't have an account? <a href="register.jsp">Register here</a>
			</p>
		</div>
	</div>
</body>
</html>