package db;

import java.io.Serializable;

public class User implements Serializable {
	private String username = "";
	private String parola = "";
	private boolean admin = false;

	// Constructors, getters, setters
	public User(String username, String parola, boolean admin) {
		this.username = username;
		this.parola = parola;
		this.admin = admin;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getParola() {
		return parola;
	}

	public void setParola(String parola) {
		this.parola = parola;
	}

	public boolean esteAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
}
