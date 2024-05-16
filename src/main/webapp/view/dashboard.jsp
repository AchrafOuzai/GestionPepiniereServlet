<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            display: flex;
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
        .stat {
            margin-bottom: 10px;
            color: #27ae60;
            font-weight: 600;
        }
        .chart-container {
            width: 80%;
            margin: 20px auto;
        }
        .links {
            margin-top: 20px;
        }
        .links a {
            margin-right: 20px;
            text-decoration: none;
            color: #2980b9;
            font-weight: 600;
        }
        .cards {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }
        .card {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 30%;
            text-align: center;
        }
        .card i {
            font-size: 50px;
            color: #27ae60;
            margin-bottom: 10px;
        }
        .card h3 {
            margin-bottom: 10px;
        
            font-weight: 600;
        }
        .card p {
            font-weight: 600;
        }
        .chart-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        .chart-small {
            width: 40%;
            margin-right: 20px;
        }
        .chart-text {
            width: 55%;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
   <div class="sidebar">
    <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="plants"><i class="fas fa-seedling"></i> Plantes</a>
    <a href="produit"><i class="fas fa-box"></i> Produits</a>
    <a href="stock.jsp"><i class="fas fa-warehouse"></i> Stock</a>
</div>
   
    <div class="container">
        <h2>Dashboard</h2>
        <p>Welcome, ${user.username}!</p>
        <div class="cards">
            <div class="card">
                <i class="fas fa-seedling"></i>
                <h3>Total Plants</h3>
                <p>${totalPlants}</p>
            </div>
            <div class="card">
                <i class="fas fa-box"></i>
                <h3>Total Products</h3>
                <p>${totalProducts}</p>
            </div>
        </div>

        <div class="chart-row">
            <div class="chart-container">
                <canvas id="statsChart"></canvas>
            </div>
            <div class="chart-small">
                <canvas id="pieChart"></canvas>
            </div>
        </div>

        <div class="links">
            <a href="plants.jsp">View Plants</a>
            <a href="products.jsp">View Products</a>
        </div>
    </div>

    <script>
        var ctx = document.getElementById('statsChart').getContext('2d');
        var statsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Plants', 'Products'],
                datasets: [{
                    label: 'Statistics',
                    data: [${totalPlants}, ${totalProducts}],
                    backgroundColor: 'rgba(46, 204, 113, 0.2)',
                    borderColor: 'rgba(46, 204, 113, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        var pieCtx = document.getElementById('pieChart').getContext('2d');
        var pieChart = new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: ['Plants', 'Products'],
                datasets: [{
                    data: [${totalPlants}, ${totalProducts}],
                    backgroundColor: [
                        'rgba(46, 204, 113, 0.7)',
                        'rgba(52, 152, 219, 0.7)'
                    ],
                    borderColor: [
                        'rgba(46, 204, 113, 1)',
                        'rgba(52, 152, 219, 1)'
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
    </script>
</body>
</html>