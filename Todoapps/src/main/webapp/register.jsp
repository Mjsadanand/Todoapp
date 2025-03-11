<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Registration</title>
<link rel="stylesheet" href="register.css">
<style>
</style>
</head>
<body>
	<div class="container">
		<h2>Student Registration</h2>

		<form action="register" method="post">
			<div class="form-group">
				<input type="text" id="username" name="username"
					placeholder="Username" required>
			</div>

			<div class="form-group">
				<input type="password" id="password" name="password"
					placeholder="Password" required>
			</div>

			<div class="form-group">
				<input type="text" id="first_name" name="first_name"
					placeholder="First Name" required>
			</div>

			<div class="form-group">
				<input type="text" id="last_name" name="last_name"
					placeholder="Last Name" required>
			</div>

			<div class="form-group">
				<input type="date" id="dob" name="dob" required>
			</div>

			<div class="form-group">
				<input type="email" id="email" name="email" placeholder="Email"
					required>
			</div>

			<button type="submit" class="btn-submit">Register</button>
		</form>

	</div>
</body>
</html>