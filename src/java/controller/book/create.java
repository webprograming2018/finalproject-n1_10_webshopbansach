/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.book;

import DAO.DAOBook;
import DAO.DAOCategory;
import Model.Book;
import Model.User;
import com.pusher.rest.Pusher;
import helper.Auth;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Collections;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author mito
 */
@WebServlet(name = "create", urlPatterns = {"/book/create"})
@MultipartConfig
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
        if(!Auth.admin(request)) {
            response.sendRedirect(request.getContextPath());
        }
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        String des = request.getParameter("des");
        String slug = request.getParameter("slug");
        int cat_id = Integer.parseInt(request.getParameter("cat_id"));
        int total_quantity = Integer.parseInt(request.getParameter("total_quantity"));
        int left_quantity = total_quantity;
        int price = Integer.parseInt(request.getParameter("price"));
        try {
            Book book = new Book();
            book.setName(name);
            book.setAuthor(author);
            book.setDes(des);
            book.setSlug(slug);
            book.setCat_id(cat_id);
            book.setTotal_quantity(total_quantity);
            book.setLeft_quantity(left_quantity);
            book.setPrice(price);
            DAOBook.save(book);
            // Upload file
            
            String appPath = request.getServletContext().getRealPath("");
            appPath = appPath.replace('\\', '/');
            
            Part image = request.getPart("image");
            String filename = Paths.get(image.getSubmittedFileName()).getFileName().toString();
            InputStream fileContent = image.getInputStream();
            byte[] buffer = new byte[fileContent.available()];
            fileContent.read(buffer);
            File target = new File(appPath + "/images/book/" + book.getSlug() + ".gif");
            OutputStream outStream = new FileOutputStream(target);
            outStream.write(buffer);
            for(User user : DAOCategory.FavoriteUser(cat_id)) {
                String channel = "new-favorite-book-" + user.getId();
                String event = "new-favorite-book";
                String book_name = book.getName();
                
                Pusher pusher = new Pusher("590190", "bb415e34026b68357364", "338f29ea01040f94756a");
                pusher.setCluster("ap1");
                pusher.setEncrypted(true);
                pusher.trigger(channel, event, Collections.singletonMap("name", book_name));
                
                // send mail to favorite user
                // sendEmail("xpeke.shin@gmail.com", "kalenz10111997", user, book);
            }
            response.sendRedirect(request.getContextPath() + "/admin/book.jsp?create=1");
        } catch (SQLException e) {
           response.sendRedirect(request.getContextPath() + "/admin/book/create.jsp?error=1");
            //
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

    
    protected void sendEmail(String emailFrom,String password, User user, Book book)
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
                message.setSubject("Your favorite category has a new book");
                String msg = "<h1 style='color: red'>Hi, " + user.getUsername() +"</h1>";
                msg += "<p>We have add a new book to your favorite categories on Demin Shop</p>";
                msg += "<p>We hope you will enjoy this book. Thank for your support</p>";
                msg += "<p>Name: " + book.getName() + "</p>";
                msg += "<p>Author: " + book.getAuthor() + "</p>";
                msg += "<a href='http://localhost:8080/book.jsp?id=" + book.getId() + "'>Click to see this book</a>";
                message.setContent(msg, "text/html; charset=utf-8");

                Transport.send(message);

        } catch (MessagingException e) {
                throw new RuntimeException(e);
        }
    }
    
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
          if (s.trim().startsWith("filename")) {
            return s.substring(s.indexOf("=") + 2, s.length() - 1);
          }
        }
        return "";
  }
}
