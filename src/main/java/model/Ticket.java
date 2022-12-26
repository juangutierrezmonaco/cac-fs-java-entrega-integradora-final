package model;

public class Ticket {
	private int id;
	private String firstname;
	private String lastname;
	private String email;
	private int quantity;
	private String category;
	
	public Ticket() {
		this(0, "", "", "", 0, "");
	}
	
	public Ticket(int id, String firstname, String lastname, String email, int quantity, String category) {
		this.id = id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.quantity = quantity;
		this.category = category;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Ticket [firstname=" + firstname + ", lastname=" + lastname + ", email=" + email + ", quantity="
				+ quantity + ", category=" + category + "]";
	}
}