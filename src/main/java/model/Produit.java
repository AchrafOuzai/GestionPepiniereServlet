package model;

public class Produit {

	private int id;
	private String nom;
	private double prix;
	private String description;
	private String type;
	private String image;
	
	
	
	public Produit(String nom, double prix, String description, String type, String image) {
		super();
		this.nom = nom;
		this.prix = prix;
		this.description = description;
		this.type=type;
		this.image=image;
	}
	

	public Produit(int id, String nom, double prix, String description, String type, String image) {
		super();
		this.id = id;
		this.nom = nom;
		this.prix = prix;
		this.description = description;
		this.type=type;
		this.image=image;
	}







	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public double getPrix() {
		return prix;
	}
	public void setPrix(double prix) {
		this.prix = prix;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	
}
