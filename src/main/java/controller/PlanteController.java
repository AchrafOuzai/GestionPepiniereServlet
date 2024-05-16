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
@WebServlet("/")
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
		
		
		String action = request.getServletPath();

		try {
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("view/listPlantes.jsp");
		
		dispatcher.forward(request, response);
	}

	private void FormAjouter(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("view/FormPlantes.jsp");
		dispatcher.forward(request, response);
	}

	private void FormModifier(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id_plante"));
		Plante planteAncien = planteDAO.Selectionnerplante(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("view/FormPlantes.jsp");
		request.setAttribute("plante", planteAncien);
		dispatcher.forward(request, response);

	}

	private void Ajouterplante(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
		String nom = request.getParameter("nom_plante");
		double prix = Double.parseDouble(request.getParameter("prix_plante")) ;
		String description = request.getParameter("description_plante");
		String type = request.getParameter("type_plante");
		
		
		
		Part part = request.getPart("image_plante");
	    InputStream fileContent = part.getInputStream();
	    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
	    int nombre;
	    byte[] donnees = new byte[1024];
	    while ((nombre = fileContent.read(donnees, 0, donnees.length)) != -1) {
	        buffer.write(donnees, 0, nombre);
	    }
	    buffer.flush();
	    byte[] bytesImage = buffer.toByteArray();
	    String img = Base64.getEncoder().encodeToString(bytesImage);

		

		Plante plante = new Plante(nom,  description,prix, type, img);
		planteDAO.Ajouterplante(plante);
		response.sendRedirect("list");
	}

	private void Modifierplante(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
		int id = Integer.parseInt(request.getParameter("id_plante"));
		String nom = request.getParameter("nom_plante");
		
		
		String prixString = request.getParameter("prix_plante");
	    double prix = 0.0;  
	    if (prixString != null && !prixString.trim().isEmpty()) {
	        try {
	            prix = Double.parseDouble(prixString);
	        } catch (NumberFormatException e) {
	            
	            e.printStackTrace();
	        }
	    }
		
		String description = request.getParameter("description_plante");
		String type = request.getParameter("type_plante");
		
		
		Part part = request.getPart("image_plante");
	    InputStream fileContent = part.getInputStream();
	    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
	    int nombre;
	    byte[] donnees = new byte[1024];
	    while ((nombre = fileContent.read(donnees, 0, donnees.length)) != -1) {
	        buffer.write(donnees, 0, nombre);
	    }
	    buffer.flush();
	    byte[] bytesImage = buffer.toByteArray();
	    String img = Base64.getEncoder().encodeToString(bytesImage);
		
		Plante plante = new Plante(id, nom, description, prix, type, img);
		planteDAO.Modifierplante(plante);
		response.sendRedirect("list");
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
	    RequestDispatcher dispatcher = request.getRequestDispatcher("listPlantes.jsp");
	    dispatcher.forward(request, response);
	}

}