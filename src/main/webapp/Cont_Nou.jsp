<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="styles.css">
<title>Login</title>
</head>
<jsp:useBean id="jb" scope="session" class="db.javabean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<form method="POST" action="">
		<div>
			<label for="username">Username:</label> <input type="text"
				id="username" name="username" required>
		</div>
		<div>
			<label for="parola">Password:</label> <input type="password"
				id="parola" name="parola" required>
		</div>
		<div>
			<label for="nume">Nume:</label> <input type="text" id="nume"
				name="nume" required>
		</div>
		<div>
			<label for="prenume">Prenume:</label> <input type="text" id="prenume"
				name="prenume" required>
		</div>
		<div>
			<label for="email">Email:</label> <input type="email" id="email"
				name="email" required>
		</div>
		<div>
			<label for="admin">Parola Admin:</label> <input type="password"
				id="admin" name="admin" required>
		</div>
		<div>
			<button type="submit">Login</button>
		</div>
	</form>

	<%

if (request.getMethod().equalsIgnoreCase("POST")) {
	boolean esteAdmin=false;
    String username = request.getParameter("username");
    String parola = request.getParameter("parola");
    String nume = request.getParameter("nume");
    String prenume = request.getParameter("preunume");
    String email = request.getParameter("email");
    String admin = request.getParameter("admin");
	jb.connect();
	if(admin=="aDmIn") esteAdmin=true;
	jb.adaugaCont(username, parola, nume, prenume, email, esteAdmin);
	jb.disconnect();
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>
