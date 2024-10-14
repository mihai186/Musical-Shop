<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.User, db.UserDao"%>
<!DOCTYPE html>
<html>
<head>
<title>Login Page</title>
</head>
<body>

	<h2>Login Page</h2>
	<form action="login.jsp" method="POST">
		<div class="container">
			<label for="username"><b>Username</b></label> <input type="text"
				placeholder="Enter Username" name="username" required> <label
				for="password"><b>Password</b></label> <input type="password"
				placeholder="Enter Password" name="password" required>

			<button type="submit">Login</button>
		</div>
	</form>


	<%
    // Only process if it's a POST request
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Retrieve form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Print the form values to verify they're being captured
        out.println("Username from form: " + username + "<br>");
        out.println("Password from form: " + password + "<br>");

        // Check if username and password are not null or empty
        if (username != null && !username.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
            // Pass the username and password to UserDao for validation
            UserDao userDao = new UserDao();
            User user = userDao.validateUser(username, password);

            if (user != null) {
                response.sendRedirect("dashboard.jsp"); // Redirect on successful login
            } else {
                out.println("<p style='color:red;'>Invalid username or password!</p>");
            }
        } else {
            out.println("<p style='color:red;'>Please enter both username and password!</p>");
        }
    }
    %>

</body>
</html>
