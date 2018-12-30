<%-- 
    Document   : header
    Created on : Dec 16, 2018, 2:04:01 PM
    Author     : mito
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAOCategory" %>
<%@ page import="Model.Category" %>
<%@ page import="helper.Auth" %>
<% String path = request.getContextPath(); %>
<%
    User user = new User();
    if(session.getAttribute("username") != null) {
        user = Auth.current(request);
    }
%>
<!DOCTYPE html>
<link rel="stylesheet" href="./css/bootstrap.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
<link rel="stylesheet" href="<%= path %>/css/datatables-custom.css">
<link rel="stylesheet" href="./css/app.css">
<link rel="stylesheet" href="./css/toastr.min.css">
<style>
        .container-fluid {
            width: 70%!important;
        }
</style>
<script>
    var context_path = "<%= path %>";
    <% 
        if(Auth.logged(request)) {
            out.print("var user_id = " + Auth.current(request).getId());
        } 
    %>
</script>
<div class="container-fluid">
    <header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
            <div class="col-4 pt-1">
                <a class="text-muted" href="">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mx-3">
                        <circle cx="10.5" cy="10.5" r="7.5"></circle>
                        <line x1="21" y1="21" x2="15.8" y2="15.8"></line>
                    </svg>
                </a>
            </div>
            <div class="col-4 text-center">
                <a class="blog-header-logo text-dark" href='<%= path %>'>Demin Shop</a>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <a id="cart-icon" class="btn btn-sm btn-outline-secondary" href='<%= path + "/cart.jsp" %>'>Cart</a>
                    </div>
                    <% if(Auth.logged(request)) { %>
                        <div class="col-md-4 text-center">
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <%= user != null ? user.getUsername() : "null" %>
                                </button>
                                <div class="dropdown-menu" id="profile" aria-labelledby="dropdownMenuButton">
                                  <a class="dropdown-item" href="<%= path + "/invoice.jsp" %>">Your Invoice</a>
                                  <a class="dropdown-item" href="<%= path + "/favorite.jsp" %>">Favorited Category</a>
                                  <a class="dropdown-item" href="<%= path + "/changepass.jsp" %>">Change Password</a>
                                  <a class="dropdown-item" href="<%= path + "/address.jsp" %>">Change Address</a>
                                </div>
                              </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <a class="btn btn-sm btn-outline-secondary" href='<%= path + "/logout" %>'>Logout</a>
                        </div>
                    <% } else { %>
                        <div class="col-md-4 text-center">
                            <a class="btn btn-sm btn-outline-secondary" href='<%= path + "/register.jsp" %>'>Sign up</a>
                        </div>
                        <div class="col-md-4 text-center">
                            <a class="btn btn-sm btn-outline-secondary" href='<%= path + "/login.jsp" %>'>Login</a>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
        <div class="col-md-2 card position-absolute m-0 p-0" id="cart">
            <div id="cart-body">
                
            </div>
            <div class="card-footer">
                <a href='<%= path + "/cart.jsp" %>' class="float-left">View all</a>
                <p class="text-muted float-right">Total: <span id="cart-total">0</span>đ</p>
            </div>
        </div>
    </header>

    <div class="nav-scroller py-1 mb-2">
        <nav class="nav d-flex justify-content-center">
            <%
                    for(Category c : DAOCategory.getListCategoryWithoutDeleted()) { 
                %>
            <a class="p-2 text-muted" href="<%= path + "/category.jsp?id=" + c.getId() %>">
                <%= c.getName() %></a>
            <%
                    }
                %>
        </nav>
    </div>

    <div class="jumbotron p-0 text-white rounded bg-dark">
        <img src='<%= path + "/images/assets/banner.jpeg" %>' width="100%">
    </div>