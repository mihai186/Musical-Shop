package db;

import java.sql.*;

public class javabean {
	String error;
	Connection con;

	public javabean() {
	}

	public void connect() throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/magazin", "root", "nuimipasa");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect()

	public void connect(String bd) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + bd, "root", "nuimipasa");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd)

	public void connect(String bd, String ip) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + ip + ":3306/" + bd, "root", "nuimipasa");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	}

	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	} // disconnect()

	public ResultSet vedeTabela(String tabel) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select * from `magazin`.`" + tabel + "`;");
			Statement stmt = con.createStatement(/*
													 * ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY
													 */);
			rs = stmt.executeQuery(queryString);

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeTabela()

	public ResultSet vedeCos(long id) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select categorie, produseCos.idIntrare, instrumente.nume, pret, cantitate, pathImagine\r\n"
					+ "	from utilizatori inner join produseCos using(idUser) inner join instrumente using(idInstrument)\r\n"
					+ "    where instrumente.idInstrument=produsecos.idInstrument and\r\n"
					+ "		utilizatori.idUser=produsecos.idUser and\r\n" + "        idUser=" + id + ";");
			Statement stmt = con.createStatement(/*
													 * ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY
													 */);
			rs = stmt.executeQuery(queryString);

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeCos()

	public ResultSet login(String u, String p) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			PreparedStatement login;
			login = con.prepareStatement("select idUser, esteAdmin from utilizatori where username=? and parola=?;");
			login.setString(1, u);
			login.setString(2, p);
			rs = login.executeQuery();

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // login()

	public void adaugaProdusCos(long idIn, long idUs, int c) throws SQLException, Exception {
		String error;
		try (PreparedStatement verif = con
				.prepareStatement("SELECT COUNT(*) FROM produseCos WHERE idInstrument = ? AND idUser = ?")) {
			verif.setLong(1, idIn);
			verif.setLong(2, idUs);

			try (ResultSet rs = verif.executeQuery()) {
				if (rs.next()) { // Move cursor to the first row
					int count = rs.getInt(1);

					if (count > 0) {
						try (PreparedStatement update = con.prepareStatement(
								"UPDATE produseCos SET cantitate = cantitate + ? WHERE idInstrument = ? AND idUser = ?")) {
							update.setInt(1, c);
							update.setLong(2, idIn);
							update.setLong(3, idUs);
							update.executeUpdate();
						}
					} else {
						try (PreparedStatement insert = con.prepareStatement(
								"INSERT INTO produseCos (idUser, idInstrument, cantitate) VALUES (?, ?, ?)")) {
							insert.setLong(1, idUs);
							insert.setLong(2, idIn);
							insert.setInt(3, c);
							insert.executeUpdate();
						}
					}
				}
			}
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila. Detalii: " + sqle.getMessage();
			throw new SQLException(error, sqle); // Include the original SQLException
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele. Detalii: " + e.getMessage();
			throw new Exception(error, e); // Include the original Exception
		}
	}// adaugaProdusCos()
	public void stergeProdusCos(long id) throws SQLException, Exception {
		try {
			PreparedStatement sterge;
			sterge = con.prepareStatement("delete from produseCos where idIntrare=?");
			sterge.setLong(1, id);
			sterge.executeUpdate();

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
	}// stergeProdusCos()
	public void stergeProdus(long id) throws SQLException, Exception {
		try {
			PreparedStatement sterge;
			sterge = con.prepareStatement("delete from instrumente where idInstrument=?");
			sterge.setLong(1, id);
			sterge.executeUpdate();

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
	}// stergeProdus()
	
	public void adaugaCont(String u, String p, String n, String pr, String em, boolean a) throws SQLException, Exception {
		try {
			PreparedStatement stm;
			stm = con.prepareStatement("insert into utilizatori(esteAdmin, nume, prenume, email, parola, username) values (?, ?, ?, ?, ?, ?);");
			stm.setBoolean(1, a);
			stm.setString(2, n);
			stm.setString(3, pr);
			stm.setString(4, em);
			stm.setString(5, p);
			stm.setString(6, u);
			stm.executeUpdate();

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
	}// adaugaCont()
	public void adaugaProdus(String n, String c, String d, Double p, String img) throws SQLException, Exception {
		try {
			PreparedStatement stm;
			stm = con.prepareStatement("insert into instrumente(categorie, nume, descriere, pret, pathImagine) values (?, ?, ?, ?, ?);");
			stm.setString(1, c);
			stm.setString(2, n);
			stm.setString(3, d);
			stm.setDouble(4, p);
			stm.setString(5, img);
			stm.executeUpdate();

		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
	}// adaugaProdus()

	public void stergeDateTabela(String[] primaryKeys, String tabela, String dupaID) throws SQLException, Exception {
		if (con != null) {
			try {
// create a prepared SQL statement
				long aux;
				PreparedStatement delete;
				delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
				for (int i = 0; i < primaryKeys.length; i++) {
					aux = java.lang.Long.parseLong(primaryKeys[i]);
					delete.setLong(1, aux);
					delete.execute();
				}
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			} catch (Exception e) {
				error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
				throw new Exception(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeDateTabela()

	public void stergeTabela(String tabela) throws SQLException, Exception {
		if (con != null) {
			try {
// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("delete from " + tabela + ";");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Stergere nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeTabela()

	public void modificaTabela(String tabela, String IDTabela, long ID, String[] campuri, String[] valori)
			throws SQLException, Exception {
		String update = "update " + tabela + " set ";
		String temp = "";
		if (con != null) {
			try {
				for (int i = 0; i < campuri.length; i++) {
					if (i != (campuri.length - 1))
						temp = temp + campuri[i] + "='" + valori[i] + "', ";
					else
						temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + " = '" + ID + "';";
				}
				update = update + temp;
// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate(update);
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of modificaTabela()

	public ResultSet intoarceLinie(String tabela, long ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where BoalaID=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); // sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinie()

	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, long ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); // sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()
}