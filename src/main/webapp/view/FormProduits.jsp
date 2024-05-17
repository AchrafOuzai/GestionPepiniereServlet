<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Produits</title>
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
            
        }
        .card {
        margin-left:200px;
            background-color: white;
            border-radius: 5px;
            border: 2px solid #27ae60; /* Green border */
            box-shadow: 0 8px 16px rgba(39, 174, 96, 0.1); /* Green box shadow */
          
            width: 500px;
           
            padding: 20px;
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


	<br>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">
				<c:if test="${produit != null}">
					<form action="modifier" method="post" enctype="multipart/form-data">
				</c:if>
				<c:if test="${produit == null}">
					<form action="ajouter" method="post" enctype="multipart/form-data">
				</c:if>

				<caption>
					<h2>
						<c:if test="${produit != null}">
            			Modifier un produit
            		</c:if>
						<c:if test="${produit == null}">
            			Ajouter un produit
            		</c:if>
					</h2>
				</caption>
<br><br>
				<c:if test="${produit != null}">
					<input type="hidden" name="id_produit" value="<c:out value='${produit.id}' />" />
				</c:if>

				<fieldset class="form-group">
					<label>Nom de produit</label> <input type="text"
						value="<c:out value='${produit.nom}' />" class="form-control"
						name="nom_produit" required="required">
				</fieldset>
<br>
				<fieldset class="form-group">
					<label>Prix de produit</label> <input type="text"
						value="<c:out value='${produit.prix}' />" class="form-control"
						name="prix_produit">
				</fieldset>
<br>
				<fieldset class="form-group">
					<label>Description de produit</label> <input type="text"
						value="<c:out value='${produit.description}' />" class="form-control"
						name="description_produit">
				</fieldset>
				<br>
				<fieldset class="form-group">
		        <label>Type de produit</label>
		        <select class="form-control" name="type_produit">
			    <option value="">Choisir un type</option>
			    <option value="physique" ${produit != null && produit.type == 'physique' ? 'selected' : ''}>Produit physique</option>
			    <option value="chimique" ${produit != null && produit.type == 'chimique' ? 'selected' : ''}>Produit chimique</option>
				</select>

    			</fieldset>
<br>
    
    			<fieldset class="form-group">
			        <label>Image de produit</label>
			        <input type="file" class="form-control" name="image_produit">
			        <c:if test="${produit != null && produit.image != null}">
			            <img src="data:image/jpg;base64,${produit.image}" alt="Image du produit" style="max-width: 100px;">
			        </c:if>
   			    </fieldset>
				
<br>
				<button type="submit" class="btn btn-success">Enregistrer</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>