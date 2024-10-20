<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="styles.css">
<title>Tabela Instrumente</title>
</head>
<jsp:useBean id="jb" scope="session" class="db.javabean" />
<jsp:setProperty name="jb" property="*" />
<body class="tabelaInstrumente">
	<%
    Long idUser = (Long) session.getAttribute("idUser");
    Boolean esteAdmin = (Boolean) session.getAttribute("esteAdmin");
%>
	<h1 align="center">Tabela Instrumente:</h1>
	<br />
	<p align="center">
		<a href="Cos.jsp"><b>Coș</b></a>
	</p>
	<table border="1" align="center">
		<tr>
			<td><b>Categorie:</b></td>
			<td><b>Nume Instrument:</b></td>
			<td><b>Descriere:</b></td>
			<td><b>Pret:</b></td>
			<td><b>Imagine:</b></td>
			<td><b>Adaugare Articol:</b></td>
		</tr>
		<%
			jb.connect();
			ResultSet rs = jb.vedeTabela("instrumente");
			while (rs.next()) {
			%>
		<tr>
			<td><%=rs.getString("categorie")%></td>
			<td><%=rs.getString("nume")%></td>
			<td><%=rs.getString("descriere")%></td>
			<td><%=rs.getString("pret")%></td>
			<td><img width=300 height=300
				src=<%=rs.getString("pathImagine") %>></td>
			<td>
				<form action="servletCos" method="post">
				<input type="hidden" name="itemId" value="<%=rs.getLong("idInstrument")%>">
				<input type="hidden" name="userId" value="<%=idUser%>">
					<input type="number" name="value" min="0" value="0">
					<button type="submit">Adauga in cos</button>
				</form>
			</td>
			<%
				}
				%>
		</tr>
	</table>
	<br />

	<%
rs.close();
jb.disconnect();
%>
	<br />
</body>
</html>