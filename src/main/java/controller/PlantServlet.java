package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import utils.DatabaseConnection;

import com.google.gson.Gson;
//Import statements

@WebServlet("/plants")
public class PlantServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     fetchPlantTypeCounts(request, response);
 }
 
 private void fetchPlantTypeCounts(HttpServletRequest request, HttpServletResponse response) 
         throws ServletException, IOException {
     Connection connection = null;
     PreparedStatement preparedStatement = null;
     ResultSet resultSet = null;

     Map<String, Integer> plantTypeCounts = new HashMap<>();

     String[] plantTypes = {"arbre", "arbust", "floar", "plantseculent"};

     try {
         connection = DatabaseConnection.getConnection();
         String countSql = "SELECT type, COUNT(*) AS count FROM plante WHERE type IN (?, ?, ?, ?) GROUP BY type";
         preparedStatement = connection.prepareStatement(countSql);
         for (int i = 0; i < plantTypes.length; i++) {
             preparedStatement.setString(i + 1, plantTypes[i]);
         }
         resultSet = preparedStatement.executeQuery();

         while (resultSet.next()) {
             String type = resultSet.getString("type");
             int count = resultSet.getInt("count");
             plantTypeCounts.put(type, count);
         }
     } catch (Exception e) {
         e.printStackTrace();
     } finally {
         DatabaseConnection.closeResultSet(resultSet);
         DatabaseConnection.closeStatement(preparedStatement);
         DatabaseConnection.closeConnection(connection);
     }

     request.setAttribute("plantTypeCounts", plantTypeCounts);
     request.getRequestDispatcher("/plants.jsp").forward(request, response);
 }
}

