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
	<h1 align="center">Tabela Instrumente:</h1>
	<br />
	<table border="1" align="center">
		<tr>
			<td><b>Categorie:</b></td>
			<td><b>Nume Instrument:</b></td>
			<td><b>Descriere:</b></td>
			<td><b>Pret:</b></td>
			<td></td>
			<td><b>Sterge:</b></td>
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
				src=<%=rs.getString("pathImagine")%>></td>
			<td>
				<form action="servletStergereInstrument" method="post">
					<input type="hidden" name="idSterge"
						value="<%=rs.getLong("idInstrument")%>">
					<button type="submit">Sterge Produs</button>
				</form>
			</td>
			<%
			}
			%>
		</tr>
	</table>
	<br />
		<p align="center">
			<a href="Adauga_Produs.jsp"><b>Adauga Produs</b></a>
		</p>
	<%
	rs.close();
	jb.disconnect();
	%>
	<br />
</body>
</html>