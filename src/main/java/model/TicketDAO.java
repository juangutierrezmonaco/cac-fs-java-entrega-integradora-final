package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.SqlConnection;

public class TicketDAO {
	private Connection cn = null;

	public TicketDAO() {
		this.cn = createDatabase();
		createTableTickets();
	}

	private Connection createDatabase() {

		String databaseName = "db_tickets_juangutierrez";
		String query = "CREATE DATABASE IF NOT EXISTS " + databaseName;

		try {
			// Creo la conexión a la raíz
			SqlConnection sqlcn = new SqlConnection("jdbc:mysql://localhost:3306/", "root", "");
			Connection cn = sqlcn.getConnection();

			// Creo la base de datos si no existe
			Statement stm = cn.createStatement();
			int result = stm.executeUpdate(query);

			if (result == 1) {
				// Si la base de datos se creó correctamente
				System.out.println("Se creó la base de datos con el nombre: " + "'" + databaseName + "'");
			}

			// Apunto la conexión a esa base de datos
			sqlcn = new SqlConnection("jdbc:mysql://localhost:3306/" + databaseName, "root", "");
			
			stm.close();
			return sqlcn.getConnection();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return null;
	}

	private boolean createTableTickets() {
		try {
			String query = "CREATE TABLE IF NOT EXISTS tickets("
					+ " id INT NOT NULL AUTO_INCREMENT, "
					+ "firstname VARCHAR(50) NOT NULL, "
					+ "lastname VARCHAR(50) NOT NULL, "
					+ "email VARCHAR(80) NOT NULL, "
					+ "ticketsQuantity INT(11) NOT NULL, "
					+ "selectedCategory VARCHAR(30) NOT NULL, "
					+ "isActive TINYINT(1) NOT NULL, "
					+ "PRIMARY KEY (id)"
					+ ") ENGINE = InnoDB;";

			// Creo la base de datos si no existe
			Statement stm = cn.createStatement();
			stm.executeUpdate(query);
			
			System.out.println("Si no existía, se creó una tabla con el nombre 'tickets' en la base de datos.");			
			stm.close();
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	// CRUD
	public int createTicket(Ticket ticket) {
		try {
			String query = "INSERT INTO tickets (firstname, lastname, email, ticketsQuantity, selectedCategory, isActive) VALUES (?,?,?,?,?,?)";
			PreparedStatement pstm = this.cn.prepareStatement(query);

			pstm.setString(1, ticket.getFirstname());
			pstm.setString(2, ticket.getLastname());
			pstm.setString(3, ticket.getEmail());
			pstm.setInt(4, ticket.getQuantity());
			pstm.setString(5, ticket.getCategory());
			pstm.setBoolean(6, true);

			pstm.executeUpdate();
			
			pstm.close();
			
			// Return the generated id (in case there's something else to do with the consult)
			query = "SELECT LAST_INSERT_ID();";
			Statement stm = this.cn.createStatement();
			ResultSet rs = stm.executeQuery(query);
			if (rs.next()) {
				return rs.getInt(1);
			}
			
			return -1;
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public Ticket readTicket(int id) {
		Ticket ticket = null;
		
		try {
			String query = "SELECT * FROM tickets WHERE id = " + id;

			Statement stm = this.cn.createStatement();
			ResultSet rs = stm.executeQuery(query);

			if (rs.next()) {
				ticket = new Ticket(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6));

				System.out.println("Ticket encontrado.");
			} else {
				System.out.println("No se encontró el ticket.");
			}

			stm.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}

		return ticket;
	}
	
	public boolean updateTicket(Ticket ticket, int id) {
		try {
			String query = "UPDATE tickets SET firstname=?, lastname=?, email=?, ticketsQuantity=?, selectedCategory=? WHERE id=?";
			PreparedStatement pstm = this.cn.prepareStatement(query);
			pstm.setString(1, ticket.getFirstname());
			pstm.setString(2, ticket.getLastname());
			pstm.setString(3, ticket.getEmail());
			pstm.setInt(4, ticket.getQuantity());
			pstm.setString(5, ticket.getCategory());
			pstm.setInt(6, id);
			int exists = pstm.executeUpdate();
			
			if (exists == 0) {
				System.out.println("No se encontró el ticket.");
			} else {
				System.out.println("Ticket dado de baja.");
			}			
			pstm.close();
            return exists != 0;
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}
		
		return false;
	}

	public void deleteTicket(int id) {
		try {
			String query = "DELETE FROM tickets WHERE id = " + id;

			Statement stm = this.cn.createStatement();
			int exists = stm.executeUpdate(query);
			if (exists == 0) {
				System.out.println("No se encontró el ticket.");
			} else {
				System.out.println("Ticket eliminado.");
			}

			stm.close();
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}
	}

	public boolean deactivateTicket(int id) {
		try {
			String query = "UPDATE tickets SET isActive=? WHERE id=?";
			PreparedStatement pstm = this.cn.prepareStatement(query);
			pstm.setBoolean(1, false);
			pstm.setInt(2, id);
			int exists = pstm.executeUpdate();
			
			if (exists == 0) {
				System.out.println("No se encontró el ticket.");
			} else {
				System.out.println("Ticket dado de baja.");
			}			
			pstm.close();
            return exists != 0;
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}
		
		return false;
	}

	public ArrayList<Ticket> getTicketsWithData(String email) {
		ArrayList<Ticket> tickets = new ArrayList<Ticket>();

		try {
			String query = "SELECT * FROM tickets WHERE isActive = true AND email=? ";

			PreparedStatement pstm = this.cn.prepareStatement(query);
			pstm.setString(1, email);

			ResultSet rs = pstm.executeQuery();
			while (rs.next()) {
				Ticket ticket = new Ticket(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6));
				tickets.add(ticket);
			}

			pstm.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}
		
		return tickets;
	}
	
	public ArrayList<Ticket> getTickets() {
		ArrayList<Ticket> tickets = new ArrayList<Ticket>();
		try {

			Statement stm = this.cn.createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM tickets WHERE isActive = true");

			while (rs.next()) {
				Ticket ticket = new Ticket(rs.getInt(1), rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
				tickets.add(ticket);
			}

			stm.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}

		return tickets;
	}
	
	// Includes the ones inactive (deleted)
	public ArrayList<Ticket> getAllAlumnos() {
		ArrayList<Ticket> tickets = new ArrayList<Ticket>();
		try {

			Statement stm = this.cn.createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM tickets");

			while (rs.next()) {
				Ticket ticket = new Ticket(rs.getInt(1), rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
				tickets.add(ticket);
			}

			stm.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("Error en la consulta.");
			System.out.println(e.getMessage());
		}

		return tickets;
	}
}
