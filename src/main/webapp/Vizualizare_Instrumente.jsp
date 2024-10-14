<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tabela Pacienti</title>
</head>
<jsp:useBean id="jb" scope="session" class="db.javabean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h1 align="center">Tabela Pacienti:</h1>
	<br />
	<p align="center">
		<a href="nou_Pacient.jsp"><b>Adauga un nou pacient.</b></a> <a
			href="index.jsp"><b>Home</b></a>
	</p>
	<form action="sterge_Pacient.jsp" method="post">
		<table border="1" align="center">
			<tr>
				<td><b>Mark:</b></td>
				<td><b>IdPacient:</b></td>
				<td><b>CNP:</b></td>
				<td><b>Nume Pacient:</b></td>
				<td><b>Prenume Pacient:</b></td>
				<td><b>Varsta:</b></td>
				<td><b>Adresa:</b></td>
				<td><b>Email:</b></td>
				<td><b>Categorie:</b></td>
				<td><b>Telefon:</b></td>
			</tr>
			<%
			jb.connect();
			ResultSet rs = jb.vedeTabela("instrumente");
			long x;
			while (rs.next()) {
				x = rs.getLong("idInstrument");
			%>
			<tr>
				<td><input type="checkbox" name="primarykey" value="<%=x%>" /></td>
				<td><%=x%></td>
				<td><%=rs.getString("CNP")%></td>
				<td><%=rs.getString("NumePacient")%></td>
				<td><%=rs.getString("PrenumePacient")%></td>
				<td><%=rs.getString("Varsta")%></td>
				<td><%=rs.getString("Adresa")%></td>
				<td><%=rs.getString("Email")%></td>
				<td><%=rs.getString("Categorie")%></td>
				<td><%=rs.getString("Telefon")%></td>
				<%
				}
				%>
			</tr>
		</table>
		<br />
		<p align="center">
			<input type="submit" value="Sterge liniile marcate">
		</p>
	</form>
	<%
rs.close();
jb.disconnect();
%>
	<br />
	<p align="center">
		<a href="index.jsp"><b>Home</b></a> <br />
	</p>
</body>
</html>