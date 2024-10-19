<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>

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
<body class="login">
    <div class="container-login">
        <h1>Login</h1> <!-- Added a title for the login form -->
        <form method="POST" action="">
            <div class="divUserParola">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="divUserParola">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <button type="submit">Login</button>
            </div>
        </form>
        <a href="Cont_Nou.jsp"><b>Cont nou</b></a>
        
    <% // Check if the form has been submitted and handle login
    String message = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        jb.connect();
        ResultSet rs = jb.login(username, password);

        if(rs != null && rs.next()){
            long idUser = rs.getLong("idUser");
            boolean esteAdmin = rs.getBoolean("esteAdmin");
            session.setAttribute("idUser", idUser);
            session.setAttribute("esteAdmin", esteAdmin);
            if(esteAdmin) response.sendRedirect("Vizualizare_Admin.jsp");
            else response.sendRedirect("Vizualizare_Instrumente.jsp");
        } else {
            message = "Username sau parola incorecte";
        }
    }
    %>
        <p class="error-message"><%= message %></p> <!-- Display the error message with a class -->
    </div>

</body>
</html>
