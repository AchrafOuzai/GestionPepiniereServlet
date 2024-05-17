package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DatabaseConnection;

public class AdminDAO {

    public boolean validateAdmin(String username, String password) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String query = "SELECT * FROM administrateur WHERE nom_utilisateur=? AND mot_passe=?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            resultSet = statement.executeQuery();

            return resultSet.next(); // Returns true if there is a matching admin, false otherwise
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                DatabaseConnection.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public int getTotalPlants() {
        int totalPlants = 0;
        String query = "SELECT COUNT(*) FROM plante"; 

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                totalPlants = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalPlants;
    }

    public int getTotalProducts() {
        int totalProducts = 0;
        String query = "SELECT COUNT(*) FROM produit"; 

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                totalProducts = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalProducts;
    }
}
