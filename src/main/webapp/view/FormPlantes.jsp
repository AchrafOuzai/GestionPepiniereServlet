<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Plantes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

	<header>
		<nav >
			

			<ul class="navbar-nav" style="margin-left:200px;font-size: 40px">
				<li><a href="<%=request.getContextPath()%>/list"
					class="nav-link"><i class="fa-solid fa-arrow-left"></i></a></li>
			</ul>
		</nav>
	</header>
	<br>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">
				<c:if test="${plante != null}">
					<form action="modifier" method="post" enctype="multipart/form-data">
				</c:if>
				<c:if test="${plante == null}">
					<form action="ajouter" method="post" enctype="multipart/form-data">
				</c:if>

				<caption>
					<h2>
						<c:if test="${plante != null}">
            			Modifier un plante
            		</c:if>
						<c:if test="${plante == null}">
            			Ajouter un plante
            		</c:if>
					</h2>
				</caption>
<br><br>
				<c:if test="${plante != null}">
					<input type="hidden" name="id_plante" value="<c:out value='${plante.id}' />" />
				</c:if>

				<fieldset class="form-group">
					<label>Nom de plante</label> <input type="text"
						value="<c:out value='${plante.nom}' />" class="form-control"
						name="nom_plante" required="required">
				</fieldset>
<br>
				<fieldset class="form-group">
					<label>Prix de plante</label> <input type="text"
						value="<c:out value='${plante.prix}' />" class="form-control"
						name="prix_plante">
				</fieldset>
<br>
				<fieldset class="form-group">
					<label>Description de plante</label> <input type="text"
						value="<c:out value='${plante.description}' />" class="form-control"
						name="description_plante">
				</fieldset>
				<br>
				<fieldset class="form-group">
		        <label>Type de plante</label>
		        <select class="form-control" name="type_plante">
			    <option value="">Choisir un type</option>
			    <option value="Arbre" ${plante != null && plante.type == 'Arbre' ? 'selected' : ''}>Arbre</option>
			    <option value="Arbuste" ${plante != null && plante.type == 'Arbuste' ? 'selected' : ''}>Arbuste</option>
			     <option value="Fleur" ${plante != null && plante.type == 'Fleur' ? 'selected' : ''}>Fleur</option>
			    <option value="Plante_succulente" ${plante != null && plante.type == 'Plante_succulente' ? 'selected' : ''}>Plante succulente</option>
				</select>

    			</fieldset>
<br>
    
    			<fieldset class="form-group">
			        <label>Image de plante</label>
			        <input type="file" class="form-control" name="image_plante">
			        <c:if test="${plante != null && plante.image != null}">
			            <img src="data:image/jpg;base64,${plante.image}" alt="Image du plante" style="max-width: 100px;">
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













