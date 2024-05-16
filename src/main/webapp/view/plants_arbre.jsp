<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Arbre Plants</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap">
       <link rel="stylesheet" href="style.css">

</head>
<body>
    <div class="sidebar">
        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="plants"><i class="fas fa-seedling"></i> Plantes</a>
        <div class="dropdown">
            <button class="dropbtn"><i class="fas fa-leaf"></i> Plant Types</button>
            <div class="dropdown-content">
                <a href="plants_arbre.jsp"><i class="fas fa-seedling"></i> Arbre</a>
                <a href="plants_arbust.jsp"><i class="fas fa-seedling"></i> Arbust</a>
                <a href="plants_floar.jsp"><i class="fas fa-seedling"></i> Floar</a>
                <a href="plants_plantseculent.jsp"><i class="fas fa-seedling"></i> Plantseculent</a>
            </div>
        </div>
        <a href="produit"><i class="fas fa-box"></i> Produits</a>
        <a href="stock.jsp"><i class="fas fa-warehouse"></i> Stock</a>
    </div>

    <div class="container" style="margin-left: 280px;">
        <h2>Arbre Plants</h2>
        <div class="search-container">
            <input type="text" id="searchInput" class="form-control" placeholder="Search for plants by name...">
            <i class="fas fa-search search-icon"></i>
        </div>
        <div id="plantCards" class="row row-cols-4">
            <!-- Use Java to fetch and display plant information for Arbre type -->
            <% 
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionpepiniereservlet", "root", "");
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM plante WHERE type='arbre'");
                    while(rs.next()){
            %>
          
                <div class="card">
                  <img src="data:image/jpg;base64,<%= encodeImage(rs.getBlob("image_plante")) %>" class="card-img">
                    <h3 class="card-title"><%= rs.getString("nom_plante") %></h3>
                    <p class="card-text"><strong>Description:</strong> <%= rs.getString("description") %></p>
                    <p class="card-text"><strong>Prix Plante:</strong> <%= rs.getDouble("prix_plante") %></p>
                
            </div>
            <% 
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                    out.println("An error occurred while fetching plant information.");
                } finally {
                    if (rs != null) {
                        try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (stmt != null) {
                        try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (con != null) {
                        try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
        </div>
        <div class="pagination">
            <button id="prevBtn" class="btn btn-primary" disabled>Precedent</button>
            <button id="nextBtn" class="btn btn-primary">Suivante</button>
          
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const searchInput = document.getElementById('searchInput');
            const plantCards = document.getElementById('plantCards');
            const cards = plantCards.getElementsByClassName('plant-card');
            const prevBtn = document.getElementById('prevBtn');
            const nextBtn = document.getElementById('nextBtn');
            const pageNum = document.getElementById('pageNum');
            const itemsPerPage = 9;
            let currentPage = 1;

            function updatePagination() {
                const totalItems = cards.length;
                const totalPages = Math.ceil(totalItems / itemsPerPage);
                currentPage = Math.min(currentPage, totalPages);

                prevBtn.disabled = currentPage === 1;
                nextBtn.disabled = currentPage === totalPages;

                for (let i = 0; i < totalItems; i++) {
                    cards[i].style.display = 'none';
                }

                const start = (currentPage - 1) * itemsPerPage;
                const end = Math.min(start + itemsPerPage, totalItems);

                for (let i = start; i < end; i++) {
                    cards[i].style.display = 'block';
                }

                pageNum.textContent = `Page ${currentPage} of ${totalPages}`;
            }

            searchInput.addEventListener('input', function () {
                const searchTerm = searchInput.value.toLowerCase();

                for (let i = 0; i < cards.length; i++) {
                    const card = cards[i];
                    const cardText = card.innerText.toLowerCase();
                    card.style.display = cardText.includes(searchTerm) ? 'block' : 'none';
                }

                // Reset pagination when searching
                currentPage = 1;
                updatePagination();
            });

            prevBtn.addEventListener('click', function () {
                if (currentPage > 1) {
                    currentPage--;
                    updatePagination();
                }
            });

            nextBtn.addEventListener('click', function () {
                if (currentPage < Math.ceil(cards.length / itemsPerPage)) {
                    currentPage++;
                    updatePagination();
                }
            });

            updatePagination();
        });
    </script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const searchInput = document.getElementById('searchInput');
        const cards = document.querySelectorAll('.card');

        function filterPlants(searchTerm) {
            const term = searchTerm.toLowerCase();
            cards.forEach(card => {
                const title = card.querySelector('.card-title').textContent.toLowerCase();
                const matches = title.includes(term);
                card.style.display = matches ? 'block' : 'none';
            });
        }

        searchInput.addEventListener('input', function () {
            const searchTerm = searchInput.value.trim();
            filterPlants(searchTerm);
        });
    });
</script>
    
</body>
</html>

<%!
    public String encodeImage(Blob blob) {
        String encodedImage = "";
        try {
            byte[] imageBytes = blob.getBytes(1, (int) blob.length());
            encodedImage = java.util.Base64.getEncoder().encodeToString(imageBytes);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return encodedImage;
    }
%>
