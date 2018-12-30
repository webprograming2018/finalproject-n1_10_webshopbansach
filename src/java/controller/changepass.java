/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.DAOUser;
import Model.User;
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
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author mito
 */
@WebServlet(name = "changepass", urlPatterns = {"/changepass"})
public class changepass extends HttpServlet {

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
            out.println("<title>Servlet changepass</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet changepass at " + request.getContextPath() + "</h1>");
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
        if(Auth.logged(request)) {
            try {
                User user = Auth.current(request);
                String old_pass = request.getParameter("oldpassword");
                String new_pass = request.getParameter("newpassword");
                String renew_pass = request.getParameter("repassword");
                if(BCrypt.checkpw(old_pass, user.getPassword())  && new_pass.equals(renew_pass)) {
                    String hashed = BCrypt.hashpw(new_pass, BCrypt.gensalt());
                    user.setPassword(hashed);
                    try {
                        DAOUser.update(user);
//                        response.sendRedirect(request.getContextPath() + "/changepass.jsp?success=1");
                        response.getWriter().print("ok");

                    } catch (SQLException ex) {
                        response.sendRedirect(request.getContextPath() + "/changepass.jsp?error=1");
                    }
                }
            } catch (SQLException ex) {
                response.sendRedirect(request.getContextPath() + "/changepass.jsp?null=1");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/changepass.jsp?error=1");
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
