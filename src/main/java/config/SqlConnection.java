package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlConnection {
	// DB Driver Variables
	private static final String CONTROLLER = "com.mysql.cj.jdbc.Driver";

	// DB Connection Variables
	private String url;
	private String username;
	private String password;

	// Method to execute the controller
	static {
		try {
			Class.forName(CONTROLLER);
		} catch (ClassNotFoundException e) {
			System.out.println("Error al establecer la carga de controlador.");
			System.out.println(e.getMessage());
		} catch (Exception e) {
			System.out.println("Error desconocido.");
			System.out.println(e.getMessage());
		}
	}

	// Constructor
	public SqlConnection(String url, String username, String password) {
		this.url = url;
		this.username = username;
		this.password = password;
	}

	// Method to return the connection to the database
	public Connection getConnection() throws SQLException {

		try {
			Connection cn = DriverManager.getConnection(this.url, this.username, this.password);
			System.out.println("Se estableció la conexión a la url '" + this.url + "'");

			return cn;
		} catch (SQLException e) {
			System.out.println("Error al cargar la conexión con la base de datos.");
			throw e;
		} catch (Exception e) {
			System.out.println("Error desconocido.");
			throw e;
		}
	}
}
