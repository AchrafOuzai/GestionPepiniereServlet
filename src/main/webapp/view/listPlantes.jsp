<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Liste des plantes</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
 <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            position: fixed;
            height: 100%;
            padding-top: 20px;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #16a085;
        }
        .container {
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
        }
        h2 {
            margin-bottom: 20px;
            font-weight: 700;
        }
        .cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .card {
            background-color: white;
            border-radius: 5px;
            border: 2px solid #27ae60; /* Green border */
            box-shadow: 0 8px 16px rgba(39, 174, 96, 0.1); /* Green box shadow */
            margin: 15px;
            width: 300px;
            overflow: hidden;
            text-align: center;
            padding: 20px;
        }
        .card h5 {
            margin: 15px 0 10px;
            font-size: 1.5em;
        }
        .card p {
            padding: 0 15px;
            font-size: 1em;
            color: #666;
        }
        .card .count {
            margin: 10px 0;
            font-size: 1.2em;
            color: #27ae60;
        }
        .card i.fas {
            color: #27ae60; /* Green color for icon */
        }
        .statistics {
            margin-top: 50px;
            text-align: center;
        }
        .chart-row {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .chart-container {
            flex: 1;
            max-width: 45%;
            padding: 20px;
        }
        .chart {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
 <div class="sidebar">
    <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="plant"><i class="fas fa-seedling"></i> Plantes</a>
    <a href="produit"><i class="fas fa-box"></i> Produits</a>
    <a href="plants"><i class="fas fa-warehouse"></i> Stock</a>
</div>

	<header>
		<nav >
			
			<div >
			<h1 style="text-align:center;">Liste des plantes</h1>
			
			</div>
					</nav>
	</header>
	<br>

	
		

		<div class="container">
    <div>
        <a href="${pageContext.request.contextPath}/plant/formNouveau" class="btn btn-success">Ajouter un plante</a>
    </div>
    <br>
    
    <form action="${pageContext.request.contextPath}/plant/rechercher" method="get">
        <div class="input-group" style="display: flex; justify-content: flex-end;">
            <input type="text" style="width: 200px; border-width: thin; margin-right:5px;" placeholder="Nom du plante" name="nomplante">
            <button class="btn btn-warning" type="submit">Rechercher</button>
        </div>
    </form>
    <br>
    
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Image</th>
                <th>ID</th>
                <th>Nom</th>
                <th>Prix</th>
                <th>Description</th>
                <th>Type</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="plante" items="${listplantes}">
                <tr>
                    <td>
                        <c:if test="${plante.image != null}">
                            <img src="data:image/jpg;base64,${plante.image}" alt="Image du plante" style="max-width: 100px;">
                        </c:if>
                    </td>
                    <td><c:out value="${plante.id}" /></td>
                    <td><c:out value="${plante.nom}" /></td>
                    <td><c:out value="${plante.prix}" /></td>
                    <td><c:out value="${plante.description}" /></td>
                    <td><c:out value="${plante.type}" /></td>
                    <td>
                        <a class="btn btn-info" href="${pageContext.request.contextPath}/plant/formModifier?id_plante=${plante.id}">
                            <i class="fa-solid fa-pen-to-square" style="font-size:20px"></i>
                        </a>
                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/plant/supprimer?id_plante=${plante.id}">
                            <i class="fa-solid fa-trash" style="font-size:20px"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
		
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>