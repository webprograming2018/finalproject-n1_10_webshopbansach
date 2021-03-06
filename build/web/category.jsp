<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@page import="DAO.DAOUser"%>
<%@page import="helper.Auth"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAOBook" %>
<%@ page import="Model.Book" %>
<%@ page import="DAO.DAOCategory" %>
<%@ page import="Model.Category" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Demin Shop</title>
</head>

<body>
    <%@ include file="layout/header.jsp" %>
    <% int cat_id = Integer.parseInt(request.getParameter("id")); %>
    <!-- Sách theo category -->
    <% Category cat = DAOCategory.find(cat_id); %>
    <div class="card bg-white mb-5">
        <div class="card-header sticky-top">
            <h4 class="text-primary float-left">
                <%= cat.getName() %>
            </h4>
            <%
                    if(Auth.logged(request)) {
                        if(DAOUser.checkFavorite(Auth.current(request).getId(), cat.getId())) {
                %>
            <button id="favorite-button-<%= cat.getId() %>" class="btn btn-sm btn-success float-right"><i class="fa fa-check"></i>
                Favorited</button>
            <%
                            
                        } else {
                %>
            <button id="favorite-button-<%= cat.getId() %>" onclick="addToFavorite(<%= cat.getId() %>)" class="btn btn-sm btn-primary float-right">Add
                To Favorite</button>
            <%
                        }
                    }
                %>
        </div>
        <div class="card-body card-deck">
            <% for(Book b : DAOBook.getBookByCon("WHERE cat_id = " + cat.getId() + " ORDER BY created_at DESC LIMIT 12")) { %>
            <div class="card zoom mb-4">
                <img class="card-img-top" src="<%= path + "/images/book/" + b.getSlug() + ".gif" %>" alt="Card image
                cap" height="400px">
                <div class="card-body">
                    <a href="<%= path + "/book.jsp?bookId=" + b.getId() %>">
                        <h5 class="card-title">
                            <%= b.getName() %>
                        </h5>
                    </a>
                    <p class="card-text text-muted">
                        <%= b.getAuthor() %>
                    </p>
                    <p class="card-text"><b>
                            <%= b.getPrice() %> đ</b></p>
                </div>
                <div class="card-footer text-center">
                        <button class="btn btn-primary btn-sm" onclick="addCart(<%= b.getId() %>)">
                                <i class="fa fa-cart-plus"></i> Add to cart
                            </button>
        
                            <button class="btn btn-danger btn-sm" onclick="addCartAndCheckout(<%= b.getId() %>)">
                                <i class="fa fa-cart-plus"></i> Buy it now
                            </button>
                </div>
            </div>
            <% } %>
        </div>
        <button class="btn btn-light load-more" cat_id="<%= cat.getId() %>">See more</button>
    </div>
    <!-- Footer -->
    <jsp:include page="./layout/footer.jsp" />
</body>

</html>