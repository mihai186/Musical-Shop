<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="styles.css">
<title>Adauga un nou instrument</title>
</head>
<body>
	<h1>Adauga un nou instrument</h1>
	<form action="servletAdaugaInstrument" method="post">
		<label for="nume">Nume:</label> <input type="text" id="nume"
			name="nume" required><br>
		<br> <label for="categorie">Categorie:</label> <input type="text"
			id="categorie" name="categorie" required><br>
		<br> <label for="pret">Pret:</label> <input type="number"
			id="pret" name="pret" step="0.01" required><br>
		<br> <label for="descriere">"Descriere":</label> <input
			type="text" id=" descriere" name="descriere" required><br>
		<br> <label for="path">"Path Imagine":</label> <input
			type="text" id="path" name="path" required><br>
		<br> <input type="submit" value="Adauga">
	</form>
</body>
</html>
