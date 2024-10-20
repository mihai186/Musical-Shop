<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="styles.css">
<title>Coș</title>
</head>
<jsp:useBean id="jb" scope="session" class="db.javabean" />
<jsp:setProperty name="jb" property="*" />
<body class="tabelaInstrumente">
	<h1 align="center">Coș Instrumente:</h1>
	<br />
	<%
	Long idUser = (Long) session.getAttribute("idUser");
	%>
	<table border="1" align="center">
		<tr>
			<td><b>Categorie:</b></td>
			<td><b>Nume Instrument:</b></td>
			<td><b>Pret:</b></td>
			<td><b>Cantitate:</b></td>
			<td><b>Imagine:</b></td>
			<td><b>Sterge:</b></td>
		</tr>
		<%
		jb.connect();
		ResultSet rs = jb.vedeCos(idUser);
		double total = 0;
		while (rs.next()) {
			total += rs.getLong("cantitate") * rs.getDouble("pret");
		%>
		<tr>
			<td><%=rs.getString("categorie")%></td>
			<td><%=rs.getString("instrumente.nume")%></td>
			<td><%=rs.getString("pret")%></td>
			<td><%=rs.getString("cantitate")%></td>
			<td><img width=200 height=200
				src=<%=rs.getString("pathImagine")%>></td>
			<td class="sterge">
				<form action="servletStergereCos" method="post">
					<input type="hidden" name="idIntrare"
						value="<%=rs.getLong("idIntrare")%>">
					<button type="submit">Sterge</button>
				</form>
			</td>
			<%
			}
			%>
		</tr>
		<tr>
			<td colspan="6" style="text-align: right;"><b>Pret total:</b> <%= total %></td>
		</tr>
	</table>
	<br />
	<p align="center">
		<a href="Vizualizare_Instrumente.jsp"><b>Inapoi la site</b></a>
	</p>
	<%
	rs.close();
	jb.disconnect();
	%>
	<br />
</body>
</html>