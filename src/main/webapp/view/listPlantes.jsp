<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Liste des plantes</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

	<header>
		<nav >
			
			<div >
			<h1 style="text-align:center;">Liste des plantes</h1>
			<hr style="width:200px;margin-left:700px;border: 3px solid #FF5733">
			</div>
					</nav>
	</header>
	<br>

	
		

		<div class="container">
		
			
			<div >

				<a href="<%=request.getContextPath()%>/formNouveau" class="btn btn-success">Ajouter un plante</a>
			</div>
			<br>
			
			<form action="<%=request.getContextPath()%>/rechercher" method="get">
			
			    <div class="input-group" style="display: flex; justify-content: flex-end;" >
			        <input type="text" style="width: 200px;border-width: thin;margin-right:5px;" placeholder="Nom du plante" name="nomplante">
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
		                	

		               		
							<td><a class="btn btn-info" href="formModifier?id_plante=<c:out value='${plante.id}' />"><i class="fa-solid fa-pen-to-square" style="font-size:20px"></i></a>
								
								<a class="btn btn-danger" href="supprimer?id_plante=<c:out value='${plante.id}' />"><i class="fa-solid fa-trash" style="font-size:20px"></i></a></td>
						</tr>
					</c:forEach>
					
				</tbody>

			</table>
		</div>
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>