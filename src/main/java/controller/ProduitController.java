package controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

import dao.ProduitDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Produit;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/produit/*")
public class ProduitController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProduitDAO produitDAO;

    public void init() {
        produitDAO = new ProduitDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        System.out.println("Action: " + action); // For debugging

        try {
            if (action == null) {
                action = "/list";
            }

            switch (action) {
                case "/formNouveau":
                    FormAjouter(request, response);
                    break;
                case "/ajouter":
                    AjouterProduit(request, response);
                    break;
                case "/supprimer":
                    SupprimerProduit(request, response);
                    break;
                case "/formModifier":
                    FormModifier(request, response);
                    break;
                case "/modifier":
                    ModifierProduit(request, response);
                    break;
                case "/rechercher":
                    RechercherProduit(request, response);
                    break;
                default:
                    listProduits(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listProduits(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Produit> listProduits = produitDAO.SelectionnerProduits();
        request.setAttribute("listProduits", listProduits);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/listProduits.jsp");
        dispatcher.forward(request, response);
    }

    private void FormAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/FormProduits.jsp");
        dispatcher.forward(request, response);
    }

    private void FormModifier(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id_produit"));
        Produit produitAncien = produitDAO.SelectionnerProduit(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/FormProduits.jsp");
        request.setAttribute("produit", produitAncien);
        dispatcher.forward(request, response);
    }

    private void AjouterProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String nom = request.getParameter("nom_produit");
        double prix = Double.parseDouble(request.getParameter("prix_produit"));
        String description = request.getParameter("description_produit");
        String type = request.getParameter("type_produit");

        Part part = request.getPart("image_produit");
        String img = convertPartToBase64(part);

        Produit produit = new Produit(nom, prix, description, type, img);
        produitDAO.AjouterProduit(produit);
        response.sendRedirect("list");
    }

    private void ModifierProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id_produit"));
        String nom = request.getParameter("nom_produit");

        String prixString = request.getParameter("prix_produit");
        double prix = 0.0;
        if (prixString != null && !prixString.trim().isEmpty()) {
            try {
                prix = Double.parseDouble(prixString);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String description = request.getParameter("description_produit");
        String type = request.getParameter("type_produit");

        Part part = request.getPart("image_produit");
        String img = convertPartToBase64(part);

        Produit produit = new Produit(id, nom, prix, description, type, img);
        produitDAO.ModifierProduit(produit);
        response.sendRedirect("list");
    }

    private void SupprimerProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id_produit"));
        produitDAO.SupprimerProduit(id);
        response.sendRedirect("list");
    }

    private void RechercherProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String nomProduit = request.getParameter("nomProduit");
        List<Produit> produits = produitDAO.RechercherProduitsParNom(nomProduit);
        request.setAttribute("listProduits", produits);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/listProduits.jsp");
        dispatcher.forward(request, response);
    }

    private String convertPartToBase64(Part part) throws IOException {
        try (InputStream fileContent = part.getInputStream();
             ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
            byte[] data = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, bytesRead);
            }
            buffer.flush();
            byte[] bytesImage = buffer.toByteArray();
            return Base64.getEncoder().encodeToString(bytesImage);
        }
    }
}
