<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.SQLException, utils.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            width: 400px;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .login-container h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .login-container input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-container input[type="submit"]:hover {
            background-color: #218838;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .icon {
            margin-right: 10px;
        }

        .image-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-image {
            width: 100px;
            height: auto;
            border-radius: 50%;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="image-container">
        <img src="plante.png" alt="Login Image" class="login-image">
    </div>
    <h2>Login</h2>
    <%
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            if (connection != null) {
    %>
                <form action="login" method="post">
                    <div>
                        <label for="username"><i class="fas fa-user icon"></i>Username:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div>
                        <label for="password"><i class="fas fa-lock icon"></i>Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <input type="submit" value="Login">
                </form>
    <%
            } else {
                throw new SQLException("Unable to establish a database connection.");
            }
        } catch (SQLException e) {
            out.println("<p class='error'>Erreur lors de la connexion à la base de données : " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    %>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p class='error'><%= request.getAttribute("errorMessage") %></p>
    <% } %>
</div>
</body>
</html>
