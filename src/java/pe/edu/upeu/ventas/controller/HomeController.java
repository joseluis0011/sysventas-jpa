/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.edu.upeu.ventas.controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pe.edu.upeu.ventas.dao.PersonaDao;
import pe.edu.upeu.ventas.dao.ProductoDao;
import pe.edu.upeu.ventas.dao.RolDao;
import pe.edu.upeu.ventas.daoimp.PersonalDaoImp;
import pe.edu.upeu.ventas.daoimp.ProductoDaoImp;
import pe.edu.upeu.ventas.daoimp.RolDaoImp;
import pe.edu.upeu.ventas.entity.Persona;
import pe.edu.upeu.ventas.entity.Rol;

/**
 *
 * @author alum.fial1
 */
public class HomeController extends HttpServlet {
    private RolDao rde = new RolDaoImp();
    private Gson g = new Gson();
    private PersonaDao dd = new PersonalDaoImp();     
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = request.getSession();
         
        PrintWriter out = response.getWriter();
        RequestDispatcher rd;
         
        int op = Integer.parseInt(request.getParameter("opc"));
        switch(op){
            case 1: out.println(g.toJson(rde.readAll()));
                    break;
            case 2: out.println(g.toJson(rde.read(Integer.parseInt(request.getParameter("id")))));
                    break;
            case 3: Rol rol = new Rol(request.getParameter("nombrerol")); 
                    rde.create(rol);
                    break;
            case 4: Rol ro = new Rol(Integer.parseInt(request.getParameter("id")), request.getParameter("nomrol"));
                    rde.update(ro);
                    break;
            case 5: rde.delete(Integer.parseInt(request.getParameter("id")));
                    break;
            case 6: out.print(g.toJson(dd.read(Integer.parseInt(request.getParameter("idpersona")))));
                    break;
            case 7: Persona p = new Persona(Integer.parseInt(request.getParameter("idpersona")), request.getParameter("nombres"),request.getParameter("apellidos"),request.getParameter("clave"));
                    out.println(dd.update(p));
                    sesion.invalidate();
                    break;    
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
