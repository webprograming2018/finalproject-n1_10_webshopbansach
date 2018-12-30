<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.DAOBook" %>
<%@ page import="DAO.DAOCategory" %>
<%@ page import="Model.Book" %>
<%@ page import="Model.Category" %>
<%
    Category cat = new Category();
    if(request.getParameter("id") != null) {
        int cat_id = Integer.parseInt(request.getParameter("id"));
        cat = DAOCategory.find(cat_id);
        if(cat == null) {
            response.sendRedirect(request.getContextPath() + "/admin/category.jsp");
        } 
    } else {
        response.sendRedirect(request.getContextPath() + "/admin/category.jsp");
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book</title>
</head>

<body>
    <%@ include file="../layout/header.jsp" %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Category: <%= cat.getName() %></span>
            </div>
            <div class="card-body">
                <table class="table table-striped table-bordered" id="book-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th>Name</th>
                            <th>Author</th>
                            <th>Status</th>
                            <th>Price</th>
                            <th>Total</th>
                            <th>Instock</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Book book : DAOCategory.books(cat)) { %>
                            <tr>
                                <td><%= book.getId() %></td>
                                <td><%= book.getName() %></td>
                                <td><%= book.getAuthor() %></td>
                                <td>
                                        <% int left_quantity = book.getLeft_quantity(); %>
                                        <% String deleted = book.getDeleted_at(); %>
                                        <span class="badge badge-<%= deleted != null ? "danger" : (left_quantity > 0 ? "success" : "warning")  %> text-white">
                                            <%= deleted != null ? "Deleted" : (left_quantity > 0 ? "Instock" : "Soldout")  %>
                                        </span>
                                    </td>
                                <td><%= book.getPrice() %></td>
                                <td class="text-center"><%= book.getTotal_quantity() %></td>
                                <td class="text-center"><%= book.getLeft_quantity() %></td>
                                <td scop="row" class="text-center">
                                        <a href='<%= path + "/admin/book/view.jsp?id=" + book.getId() %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                                        <a href='<%= path + "/admin/book/edit.jsp?id=" + book.getId() %>' class="btn btn-sm btn-success"><i class="fa fa-edit"></i></a>
                                        <% if(deleted != null) { %>
                                            <button onclick="restoreBook(<%= book.getId() %>)" class="btn btn-sm btn-danger"><i class="fa fa-undo"></i></button>
                                        <% } else { %>
                                            <button onclick="deleteBook(<%= book.getId() %>)" class="btn btn-sm btn-danger"><i class="fa fa-trash-alt"></i></button>
                                        <% } %>
                                    </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
</body>
<script>
    $("#book-index").DataTable();
</script>
</html>