/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.DAOBook;
import Model.Book;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author mito
 */
@WebServlet(name = "LoadMore", urlPatterns = {"/loadmore"})
public class LoadMore extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoadMore</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadMore at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("application/json;charset=UTF-8");
        String load_mode = request.getParameter("mode");
        int page = Integer.parseInt(request.getParameter("page"));
        String sql = new String();
        if (load_mode != null && load_mode.equals("new")) {
            sql = "ORDER BY created_at DESC LIMIT " + ((page - 1)*4) + ",4";
        } else if(load_mode != null && load_mode.equals("hot")) {
            sql = "ORDER BY total_quantity - left_quantity DESC LIMIT " + ((page - 1)*4) + ",4";
        } else {
            int cat_id = Integer.parseInt(request.getParameter("cat"));
            sql = "WHERE cat_id = " + cat_id + " ORDER BY created_at DESC LIMIT " + ((page - 1)*4) + ",4";
        }
        try (PrintWriter out = response.getWriter()) {
            ArrayList<Book> new_books = DAOBook.getBookByCon(sql);
            Gson result = new Gson();
            out.print(result.toJson(new_books));
        } catch (SQLException e) {
            System.out.println("Failed");
        } 
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
