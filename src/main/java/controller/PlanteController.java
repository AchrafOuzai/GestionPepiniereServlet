package controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

import dao.PlanteDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Plante;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/plant/*")
public class PlanteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PlanteDAO planteDAO;

    public void init() {
        planteDAO = new PlanteDAO();
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
                    Ajouterplante(request, response);
                    break;
                case "/supprimer":
                    Supprimerplante(request, response);
                    break;
                case "/formModifier":
                    FormModifier(request, response);
                    break;
                case "/modifier":
                    Modifierplante(request, response);
                    break;
                case "/rechercher":
                    Rechercherplante(request, response);
                    break;
                default:
                    listplantes(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listplantes(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Plante> listplantes = planteDAO.Selectionnerplantes();
        request.setAttribute("listplantes", listplantes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/listPlantes.jsp");
        dispatcher.forward(request, response);
    }

    private void FormAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/FormPlantes.jsp");
        dispatcher.forward(request, response);
    }

    private void FormModifier(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id_plante"));
        Plante planteAncien = planteDAO.Selectionnerplante(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/FormPlantes.jsp");
        request.setAttribute("plante", planteAncien);
        dispatcher.forward(request, response);
    }

    private void Ajouterplante(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException, ServletException {
        try {
            String nom = request.getParameter("nom_plante");
            double prix = Double.parseDouble(request.getParameter("prix_plante"));
            String description = request.getParameter("description_plante");
            String type = request.getParameter("type_plante");

            Part part = request.getPart("image_plante");
            String img = convertPartToBase64(part);

            Plante plante = new Plante(nom, description, prix, type, img);
            planteDAO.Ajouterplante(plante);
            response.sendRedirect("list");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            throw new ServletException("Invalid input for price");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("An error occurred while adding the plant");
        }
    }

    private void Modifierplante(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id_plante"));
            String nom = request.getParameter("nom_plante");
            double prix = Double.parseDouble(request.getParameter("prix_plante"));
            String description = request.getParameter("description_plante");
            String type = request.getParameter("type_plante");

            Part part = request.getPart("image_plante");
            String img = convertPartToBase64(part);

            Plante plante = new Plante(id, nom, description, prix, type, img);
            planteDAO.Modifierplante(plante);
            response.sendRedirect("list");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            throw new ServletException("Invalid input for price");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("An error occurred while updating the plant");
        }
    }


    private void Supprimerplante(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id_plante"));
        planteDAO.Supprimerplante(id);
        response.sendRedirect("list");
    }

    private void Rechercherplante(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String nomplante = request.getParameter("nomplante");
        List<Plante> plantes = planteDAO.RechercherplantesParNom(nomplante);
        request.setAttribute("listplantes", plantes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/listPlantes.jsp");
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
