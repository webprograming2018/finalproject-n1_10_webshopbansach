/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import Model.Cart;
import com.google.gson.Gson;

import DAO.DAOBook;
import DAO.DAOInvoice;
import DAO.DAOUser;
import Model.Book;

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
import javax.servlet.http.HttpSession;

/**
 *
 * @author mito
 */
@WebServlet(name = "checkout", urlPatterns = {"/checkout"})
public class checkout extends HttpServlet {

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
            out.println("<title>Servlet checkout</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet checkout at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        // Check login
        if (session.getAttribute("username") == null) {
            response.setCharacterEncoding("UTF-8");
            response.setStatus(422);
            response.getWriter().print("Your must login first");
            return;
        }
        int user_id = Integer.parseInt(session.getAttribute("id").toString());
        Gson json = new Gson();
        String str = request.getParameter("cart");
        Cart[] data = json.fromJson(str, Cart[].class);
        // invoice info
        if(data.length < 1) {
            return;
        }
        int total_book = 0;
        int total = 0;
        // Check if left_quantity > invoice_quantity
        for(Cart cart : data) {
            try {
                Book book = DAOBook.findBook(cart.id);
                if(book.getLeft_quantity() < cart.invoice_quantity) {
                    response.setCharacterEncoding("UTF-8");
                    response.setStatus(422);
                    response.getWriter().print(book.getName() + " only has " + book.getLeft_quantity() + " left");
                    return;
                }
            } catch (SQLException ex) {
                Logger.getLogger(checkout.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        // Create invoice
        for(Cart cart : data) {
            try {
                Book book = DAOBook.findBook(cart.id);
                book.setLeft_quantity(book.getLeft_quantity() - cart.invoice_quantity);
                DAOBook.update(book);
                cart.price = book.getPrice();
                total += cart.price * cart.invoice_quantity;
                total_book += cart.invoice_quantity;
            } catch (SQLException ex) {
                Logger.getLogger(checkout.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        try {
            int invoice_id = 0;
            String address = DAOUser.find(user_id).getAddress();
            invoice_id = DAOInvoice.save(user_id, total_book, total, address);
            if(invoice_id > 0) {
                for(Cart cart : data) {
                    DAOInvoice.attach(invoice_id, cart);
                }
            }
            session.setAttribute("cart", null);
            Gson gson = new Gson();
            response.getWriter().print(gson.toJson("ok"));
            
        } catch (SQLException ex) {
            Logger.getLogger(checkout.class.getName()).log(Level.SEVERE, null, ex);
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
