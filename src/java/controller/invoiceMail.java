/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.DAOInvoice;
import DAO.DAOUser;
import Model.Book;
import Model.Invoice;
import Model.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
@WebServlet(name = "invoiceMail", urlPatterns = {"/invoiceMail"})
public class invoiceMail extends HttpServlet {

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
            out.println("<title>Servlet invoiceMail</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet invoiceMail at " + request.getContextPath() + "</h1>");
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
        Gson json = new Gson();
        int user_id = Integer.parseInt(session.getAttribute("id").toString());
        int invoice_id = Integer.parseInt(request.getParameter("invoice_id"));
        try {
            if(DAOInvoice.find(invoice_id).getUser_id() == user_id) {
                sendEmail("xpeke.shin@gmail.com", "kalenz10111997", DAOUser.find(user_id), DAOInvoice.find(invoice_id), DAOInvoice.getBookInvoice(invoice_id));
            }
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print(json.toJson("ok"));
        } catch (SQLException ex) {
            Logger.getLogger(invoiceMail.class.getName()).log(Level.SEVERE, null, ex);
            response.setStatus(404);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print(json.toJson("faild"));
        }
    }

    
    protected void sendEmail(String emailFrom,String password, User user,Invoice invoice, ArrayList<Map<String, String>> books)
    {
        String emailTo = user.getEmail();
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
          new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(emailFrom, password);
                }
          });

        try {

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(emailFrom));
                message.setRecipients(Message.RecipientType.TO,
                        InternetAddress.parse(emailTo));
                message.setSubject("Here is your new order information");
                String msg =  "";
                msg = "<h1 style='color: red'>Hi, " + user.getUsername() +"</h1>";
                msg += "<h3>Order Number: #" + invoice.getId() + "</h3>";
                // Render book list
                msg += "<table><thead><tr><th>#</th><th>Name</th><th>Quantity</th><th>Price</th><th>Total</th></tr></thead>";
                msg += "<tbody>";
                for(Map<String, String> book : books) {
                    msg += "<tr>";
                    msg += "<td>" + book.get("id") + "</td>";
                    msg += "<td>" + book.get("name") + "</td>";
                    msg += "<td>" + book.get("invoice_quantity") + "</td>";
                    msg += "<td>" + book.get("invoice_price") + "</td>";
                    msg += "<td>" + Integer.parseInt(book.get("invoice_quantity")) * Integer.parseInt(book.get("invoice_price")) + "</td>";
                    msg += "</tr>";
                }
                msg += "</tbody></table>";
                message.setContent(msg, "text/html; charset=utf-8");

                Transport.send(message);

        } catch (MessagingException e) {
                throw new RuntimeException(e);
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
