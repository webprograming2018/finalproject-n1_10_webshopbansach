<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.DAOCategory" %>
<%@ page import="Model.Category" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book</title>
</head>

<body>
    <%@ include file="./layout/header.jsp" %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Category</span>
                <a href='<%= path + "/admin/category/create.jsp" %>' class="btn btn-success btn-sm float-right">Add New Category</a>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped" id="category-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Status</th>
                            <th scope="col">Created</th>
                            <th scope="col">Updated</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Category cat : DAOCategory.getListCategory()) { %>
                        <tr>
                            <th scope="row"><%= cat.getId() %></th>
                            <td><%= cat.getName() %></td>
                            <td>
                                    <% String deleted = cat.getDeleted_at(); %>
                                    <span class="badge badge-<%= deleted != null ? "danger" : "success" %> text-white">
                                        <%= deleted != null ? "Deleted" : "Active"  %>
                                    </span>
                                </td>
                            <td><%= cat.getCreated_at() %></td>
                            <td><%= cat.getUpdated_at() %></td>
                            <td class="text-center">
                                <a href='<%= path + "/admin/category/view.jsp?id=" + cat.getId() %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                                <a href='<%= path + "/admin/category/edit.jsp?id=" + cat.getId() %>' class="btn btn-sm btn-success"><i class="fa fa-edit"></i></a>
                                <% if(deleted != null) { %>
                                    <button onclick="restoreCategory(<%= cat.getId() %>)" class="btn btn-sm btn-danger"><i class="fa fa-undo"></i></button>
                                <% } else { %>
                                    <button onclick="deleteCategory(<%= cat.getId() %>)" class="btn btn-sm btn-danger"><i class="fa fa-trash-alt"></i></button>
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
    <jsp:include page="./layout/footer.jsp" />
</body>
<script>
    $("#category-index").DataTable();
</script>
</html>