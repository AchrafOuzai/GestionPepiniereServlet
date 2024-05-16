package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import model.Plante;






public class PlanteDAO {
	private String url = "jdbc:mysql://localhost:3306/gestionpepiniereservlet?useSSL=false";
	private String nomUtilisateur = "root";
	private String motPasse = "";

	private static final String INSERER_plante_SQL = "INSERT INTO plante" + "  (nom_plante, description_plante,  prix_plante,type_plante,image_plante) VALUES "
			+ " (?, ?, ?, ?, ?);";

	private static final String SELECT_plante_PAR_ID = "select id_plante,nom_plante,description_plante, type_plante,prix_plante, image_plante from plante where 	id_plante =?";
	private static final String SELECT_planteS = "select * from plante";
	private static final String SUPPRIMER_plante_SQL = "delete from plante where 	id_plante = ?;";
	private static final String MODIFIER_plante_SQL = "update plante set nom_plante = ?, description_plante =?,prix_plante= ?, type_plante =?, image_plante =? where 	id_plante = ?;";
	private static final String RECHERCHER_PAR_NOM = "SELECT * FROM plante WHERE nom_plante LIKE ?";
	public PlanteDAO() {
		
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

	public void Ajouterplante(Plante plante) throws SQLException {
		System.out.println(INSERER_plante_SQL);
		
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERER_plante_SQL)) {
			preparedStatement.setString(1, plante.getNom());
			preparedStatement.setString(2, plante.getDescription());
			preparedStatement.setDouble(3, plante.getPrix());
			preparedStatement.setString(4, plante.getType());
			
			
			byte[] imageBytes = Base64.getDecoder().decode(plante.getImage());
	        
	        
	        preparedStatement.setBytes(5, imageBytes);
			
			
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			  e.printStackTrace();
		}
	}

	public Plante Selectionnerplante(int id) {
		Plante plante = null;
		
		try (Connection connection = getConnection();
				
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_plante_PAR_ID);) {
			preparedStatement.setInt(1, id);
			System.out.println(preparedStatement);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				String nom = rs.getString("nom_plante");
				String description = rs.getString("description_plante");
				Double prix = rs.getDouble("prix_plante");
				String type = rs.getString("type_plante");
				byte[] image = rs.getBytes("image_plante");
				String base64Image = Base64.getEncoder().encodeToString(image);
				plante = new Plante(id, nom, description, prix, type, base64Image);
			}
		} catch (SQLException e) {
			  e.printStackTrace();
		}
		return plante;
	}

	public List<Plante> Selectionnerplantes() {

		
		List<Plante> plantes = new ArrayList<>();
		
		try (Connection connection = getConnection();

				
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_planteS);) {
			System.out.println(preparedStatement);
			
			ResultSet rs = preparedStatement.executeQuery();

			
			while (rs.next()) {
				int id = rs.getInt("id_plante");
				String nom = rs.getString("nom_plante");
				String description = rs.getString("description_plante");
				Double prix = rs.getDouble("prix_plante");
				String type = rs.getString("type_plante");
				byte[] image = rs.getBytes("image_plante");
				String base64Image = Base64.getEncoder().encodeToString(image);
				plantes.add(new Plante(id, nom, description, prix, type, base64Image));
			}
		} catch (SQLException e) {
			  e.printStackTrace();
		}
		return plantes;
	}

	public boolean Supprimerplante(int id) throws SQLException {
		boolean lignesSupprimees;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(SUPPRIMER_plante_SQL);) {
			statement.setInt(1, id);
			lignesSupprimees = statement.executeUpdate() > 0;
		}
		return lignesSupprimees;
	}

	public boolean Modifierplante(Plante plante) throws SQLException {
		boolean lignesModifiees;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(MODIFIER_plante_SQL);) {
			statement.setString(1, plante.getNom());
			statement.setString(3, plante.getDescription());
			statement.setDouble(2, plante.getPrix());
			statement.setString(4, plante.getType());
			
			byte[] imageBytes = Base64.getDecoder().decode(plante.getImage());
	        
	        
	        statement.setBytes(5, imageBytes);
			statement.setInt(6, plante.getId());

			lignesModifiees = statement.executeUpdate() > 0;
		}
		return lignesModifiees;
	}
	
	public List<Plante> RechercherplantesParNom(String nomplante) {
	    List<Plante> plantes = new ArrayList<>();
	    
	    
	    try (Connection connection = getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(RECHERCHER_PAR_NOM)) {
	        preparedStatement.setString(1, "%" + nomplante + "%"); 
	        
	        ResultSet rs = preparedStatement.executeQuery();
	        
	        while (rs.next()) {
	            int id = rs.getInt("id_plante");
	            String nom = rs.getString("nom_plante");
	            String description = rs.getString("description_plante");
	            double prix = rs.getDouble("prix_plante");
	            String type = rs.getString("type_plante");
	            byte[] image = rs.getBytes("image_plante");
	            String base64Image = Base64.getEncoder().encodeToString(image);
	            plantes.add(new Plante(id, nom,  description,prix, type, base64Image));
	        }
	    } catch (SQLException e) {
	    	  e.printStackTrace();
	    }
	    
	    return plantes;
	}

	

}

