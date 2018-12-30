/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.imports;

import DAO.DAOBook;
import DAO.DAOImport;
import Model.Book;
import Model.BookImport;
import Model.Import;
import com.google.gson.Gson;
import helper.Auth;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author mito
 */
@WebServlet(name = "createImport", urlPatterns = {"/import/create"})
public class create extends HttpServlet {

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
            out.println("<title>Servlet create</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet create at " + request.getContextPath() + "</h1>");
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
        if(Auth.admin(request)) {
            request.setCharacterEncoding("UTF-8");
            String publisher = request.getParameter("publisher");
            String note = request.getParameter("note");
            String str = request.getParameter("cart");
            Gson json = new Gson();
            BookImport[] data = json.fromJson(str, BookImport[].class);
            Import imp = new Import();
            imp.setPublisher(publisher);
            imp.setNote(note);
            int imp_id = 0;
            try {
                imp_id = DAOImport.save(imp);
            } catch (SQLException ex) {
                Logger.getLogger(create.class.getName()).log(Level.SEVERE, null, ex);
            }
            for(BookImport bimp : data) {
                try {
                    Book book = DAOBook.findBook(bimp.id);
                    book.setTotal_quantity(book.getTotal_quantity()+bimp.quantity);
                    book.setLeft_quantity(book.getLeft_quantity()+bimp.quantity);
                    DAOBook.update(book);
                    DAOImport.attach(imp_id, bimp);
                } catch (SQLException ex) {
                    Logger.getLogger(create.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            response.getWriter().print(json.toJson("Import has been saved!"));
        } else {
            response.setStatus(404);
            Gson json = new Gson();
            response.getWriter().print(json.toJson("fail"));
        }
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
