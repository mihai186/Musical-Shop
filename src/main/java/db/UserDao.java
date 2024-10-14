package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	String error;
	Connection con;

	public User validateUser(String username, String parola) {
		User user = null;
		System.out.println("Username: " + username);
		System.out.println("Password: " + parola);
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
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

			System.out.println("Username: " + username);
			System.out.println("Password: " + parola);

			String sql = "SELECT username, parola, esteAdmin FROM utilizatori WHERE username = ? AND parola = ? ;";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, parola);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				user = new User(rs.getString("username"), rs.getString("parola"), rs.getBoolean("esteAdmin"));
				System.out.println("aaaa");
			}

			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}
}
