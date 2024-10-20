<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <title>Adauga un nou instrument</title>
</head>
<body class="adaugaProdus">
    <form action="servletAdaugaInstrument" method="post">
        <h1>Adauga un nou instrument</h1><br>
        <label for="nume">Nume:</label>
        <input type="text" id="nume" name="nume" required>

        <label for="categorie">Categorie:</label>
        <input type="text" id="categorie" name="categorie" required>

        <label for="pret">Pret:</label>
        <input type="number" id="pret" name="pret" step="0.01" required>

        <label for="descriere">Descriere:</label>
        <input type="text" id="descriere" name="descriere" required>

        <label for="path">Path Imagine:</label>
        <input type="text" id="path" name="path" required>

        <input type="submit" value="Adauga">
    </form>
</body>
</html>
