<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="DAO.DAOBook" %>
<%@ page import="Model.Book" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book's Detail</title>
    </head>
    <body>
        <%
            Book book = new Book();
            int id = Integer.parseInt(request.getParameter("bookId"));
            book = DAOBook.findBook(id);
        %>
        <%@ include file="./layout/header.jsp" %>
        <!-- Main -->
        <h2 class="text-muted">Thông tin sách</h2>
        <hr>
        <div class="row mb-5">
            <div class="col-md-4 text-center">
                <img src="<%= path + "/images/book/" + book.getSlug() + ".gif" %>" alt="Card image ca-p" width="100%">
            </div>
            <div class="col-md-8">
                <h4 class="text-primary mb-3">
                    <%= book.getName() %>
                </h4>
                <p class="text-muted">
                    <%= book.getAuthor() %>
                </p>
                    <button class="btn btn-primary" onclick="addCart(<%= book.getId() %>)"><i class="fa fa-cart-plus"></i> Add to cart</button>
                    <p class="text-muted mt-2">In-stock: <%= book.getLeft_quantity() %></p>
                <p class="text-muted mt-5">
                    Description:
                </p>
                <p class="text-muted">
                    <%= book.getDes() %>
                </p>
            </div>
        </div>
        <!-- Footer -->
        <jsp:include page="./layout/footer.jsp"/>
    </body>
</html>
