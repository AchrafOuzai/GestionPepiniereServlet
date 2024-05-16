package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import model.Produit;




public class ProduitDAO {
	private String url = "jdbc:mysql://localhost:3306/gestionpepiniereservlet?useSSL=false";
	private String nomUtilisateur = "root";
	private String motPasse = "";

	private static final String INSERER_PRODUIT_SQL = "INSERT INTO produit" + "  (nom_produit, prix_produit, description_produit,type_produit,image_produit) VALUES "
			+ " (?, ?, ?, ?, ?);";

	private static final String SELECT_PRODUIT_PAR_ID = "select id_produit,nom_produit,prix_produit,description_produit, type_produit, image_produit from produit where id_produit =?";
	private static final String SELECT_PRODUITS = "select * from produit";
	private static final String SUPPRIMER_PRODUIT_SQL = "delete from produit where id_produit = ?;";
	private static final String MODIFIER_PRODUIT_SQL = "update produit set nom_produit = ?,prix_produit= ?, description_produit =?, type_produit =?, image_produit =? where id_produit = ?;";
	private static final String RECHERCHER_PAR_NOM = "SELECT * FROM produit WHERE nom_produit LIKE ?";
	public ProduitDAO() {
		
	}

	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, nomUtilisateur, motPasse);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}

	public void AjouterProduit(Produit produit) throws SQLException {
		System.out.println(INSERER_PRODUIT_SQL);
		
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERER_PRODUIT_SQL)) {
			preparedStatement.setString(1, produit.getNom());
			preparedStatement.setDouble(2, produit.getPrix());
			preparedStatement.setString(3, produit.getDescription());
			preparedStatement.setString(4, produit.getType());
			
			
			byte[] imageBytes = Base64.getDecoder().decode(produit.getImage());
	        
	        
	        preparedStatement.setBytes(5, imageBytes);
			
			
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			  e.printStackTrace();
		}
	}

	public Produit SelectionnerProduit(int id) {
		Produit produit = null;
		
		try (Connection connection = getConnection();
				
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUIT_PAR_ID);) {
			preparedStatement.setInt(1, id);
			System.out.println(preparedStatement);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				String nom = rs.getString("nom_produit");
				Double prix = rs.getDouble("prix_produit");
				String description = rs.getString("description_produit");
				String type = rs.getString("type_produit");
				byte[] image = rs.getBytes("image_produit");
				String base64Image = Base64.getEncoder().encodeToString(image);
				produit = new Produit(id, nom, prix, description, type, base64Image);
			}
		} catch (SQLException e) {
			  e.printStackTrace();
		}
		return produit;
	}

	public List<Produit> SelectionnerProduits() {

		
		List<Produit> produits = new ArrayList<>();
		
		try (Connection connection = getConnection();

				
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUITS);) {
			System.out.println(preparedStatement);
			
			ResultSet rs = preparedStatement.executeQuery();

			
			while (rs.next()) {
				int id = rs.getInt("id_produit");
				String nom = rs.getString("nom_produit");
				Double prix = rs.getDouble("prix_produit");
				String description = rs.getString("description_produit");
				String type = rs.getString("type_produit");
				byte[] image = rs.getBytes("image_produit");
				String base64Image = Base64.getEncoder().encodeToString(image);
				produits.add(new Produit(id, nom, prix, description, type, base64Image));
			}
		} catch (SQLException e) {
			  e.printStackTrace();
		}
		return produits;
	}

	public boolean SupprimerProduit(int id) throws SQLException {
		boolean lignesSupprimees;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(SUPPRIMER_PRODUIT_SQL);) {
			statement.setInt(1, id);
			lignesSupprimees = statement.executeUpdate() > 0;
		}
		return lignesSupprimees;
	}

	public boolean ModifierProduit(Produit produit) throws SQLException {
		boolean lignesModifiees;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(MODIFIER_PRODUIT_SQL);) {
			statement.setString(1, produit.getNom());
			statement.setDouble(2, produit.getPrix());
			statement.setString(3, produit.getDescription());
			statement.setString(4, produit.getType());
			
			byte[] imageBytes = Base64.getDecoder().decode(produit.getImage());
	        
	        
	        statement.setBytes(5, imageBytes);
			statement.setInt(6, produit.getId());

			lignesModifiees = statement.executeUpdate() > 0;
		}
		return lignesModifiees;
	}
	
	public List<Produit> RechercherProduitsParNom(String nomProduit) {
	    List<Produit> produits = new ArrayList<>();
	    
	    
	    try (Connection connection = getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(RECHERCHER_PAR_NOM)) {
	        preparedStatement.setString(1, "%" + nomProduit + "%"); 
	        
	        ResultSet rs = preparedStatement.executeQuery();
	        
	        while (rs.next()) {
	            int id = rs.getInt("id_produit");
	            String nom = rs.getString("nom_produit");
	            double prix = rs.getDouble("prix_produit");
	            String description = rs.getString("description_produit");
	            String type = rs.getString("type_produit");
	            byte[] image = rs.getBytes("image_produit");
	            String base64Image = Base64.getEncoder().encodeToString(image);
	            produits.add(new Produit(id, nom, prix, description, type, base64Image));
	        }
	    } catch (SQLException e) {
	    	  e.printStackTrace();
	    }
	    
	    return produits;
	}

	

}
