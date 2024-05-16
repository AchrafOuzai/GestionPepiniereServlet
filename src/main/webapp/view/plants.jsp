<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Plants</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap">
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
    <a href="products.jsp"><i class="fas fa-box"></i> Produits</a>
    <a href="stock.jsp"><i class="fas fa-warehouse"></i> Stock</a>
</div>
    
    <div class="container">
        <h2>Plant Types and Counts</h2>
        <div class="cards">
         <%
    Map<String, Integer> plantTypeCounts = (Map<String, Integer>) request.getAttribute("plantTypeCounts");
    if (plantTypeCounts != null && !plantTypeCounts.isEmpty()) {
        String[] plantTypes = {"arbre", "arbust", "floar", "plantseculent"};
        String[] icons = {"fa-tree", "fa-seedling", "fa-seedling", "fa-leaf"}; 
        String[] links = {"plants_arbre.jsp", "plants_arbust.jsp", "plants_floar.jsp", "plants_plantseculent.jsp"};
        for (int i = 0; i < plantTypes.length; i++) {
            String type = plantTypes[i];
            int count = plantTypeCounts.getOrDefault(type, 0);
%>
            <a href="<%= links[i] %>">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><% if (!icons[i].isEmpty()) { %><i class="fas <%= icons[i] %>"></i> <% } %> <%= type %></h5>
                        <p class="card-text"> <%= count %></p>
                    </div>
                </div>
            </a>
<%
        }
    } else {
%>
        <p>No plant information available.</p>
<%
    }
%>
         
        </div>

        <!-- Statistics Section -->
        <div class="statistics">
            <h2>Plant Type Statistics</h2>
            <div class="chart-row">
                <div class="chart-container">
                    <canvas id="plantTypeChart" class="chart"></canvas>
                </div>
                <div class="chart-container">
                    <canvas id="plantTypeColumnChart" class="chart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart.js Library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var ctx = document.getElementById('plantTypeChart').getContext('2d');
        var plantTypeChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Arbre', 'Arbust', 'Floar', 'Plantseculent'],
                datasets: [{
                    data: [<%= plantTypeCounts.getOrDefault("arbre", 0) %>, 
                           <%= plantTypeCounts.getOrDefault("arbust", 0) %>, 
                           <%= plantTypeCounts.getOrDefault("floar", 0) %>, 
                           <%= plantTypeCounts.getOrDefault("plantseculent", 0) %>],
                    backgroundColor: [
                        'rgba(46, 204, 113, 0.7)',
                        'rgba(52, 152, 219, 0.7)',
                        'rgba(241, 196, 15, 0.7)',
                        'rgba(155, 89, 182, 0.7)'
                    ],
                    borderColor: [
                        'rgba(46, 204, 113, 1)',
                        'rgba(52, 152, 219, 1)',
                        'rgba(241, 196, 15, 1)',
                        'rgba(155, 89, 182, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                }
            }
        });

        // Column Chart for Plant Types
        var columnCtx = document.getElementById('plantTypeColumnChart').getContext('2d');
        var plantTypeColumnChart = new Chart(columnCtx, {
            type: 'bar',
            data: {
                labels: ['Arbre', 'Arbust', 'Floar', 'Plantseculent'],
                datasets: [{
                    label: 'Plant Types Count',
                    data: [<%= plantTypeCounts.getOrDefault("arbre", 0) %>, 
                           <%= plantTypeCounts.getOrDefault("arbust", 0) %>, 
                           <%= plantTypeCounts.getOrDefault("floar", 0) %>, 
                           <%= plantTypeCounts.getOrDefault("plantseculent", 0) %>],
                    backgroundColor: [
                        'rgba(46, 204, 113, 0.7)',
                        'rgba(52, 152, 219, 0.7)',
                        'rgba(241, 196, 15, 0.7)',
                        'rgba(155, 89, 182, 0.7)'
                    ],
                    borderColor: [
                        'rgba(46, 204, 113, 1)',
                        'rgba(52, 152, 219, 1)',
                        'rgba(241, 196, 15, 1)',
                        'rgba(155, 89, 182, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
