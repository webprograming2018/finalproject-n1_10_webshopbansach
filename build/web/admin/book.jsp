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
                <span>Book</span>
                <a href='<%= path + "/admin/book/create.jsp" %>' class="btn btn-success btn-sm float-right">Add New Book</a>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped" id="book-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Status</th>
                            <th scope="col">Instock</th>
                            <th scope="col">Total</th>
                            <th scope="col">Author</th>
                            <th scope="col">Category</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Map<String, String> book : DAOBook.getListBook()) { %>
                        <tr>
                            <th scope="row"><%= book.get("id") %></th>
                            <td><%= book.get("name") %></td>
                            <td>
                                <% int left_quantity = Integer.parseInt(book.get("left_quantity")); %>
                                <% String deleted = book.get("deleted_at"); %>
                                <span class="badge badge-<%= deleted != null ? "danger" : (left_quantity > 0 ? "success" : "warning")  %> text-white">
                                    <%= deleted != null ? "Deleted" : (left_quantity > 0 ? "Instock" : "Soldout")  %>
                                </span>
                            </td>
                            <td class="text-center"><%= book.get("left_quantity") %></td>
                            <td class="text-center"><%= book.get("total_quantity") %></td>
                            <td><%= book.get("author") %></td>
                            <td><%= book.get("cat_name") %></td>
                            <td scope="row" class="text-center">
                                <a href='<%= path + "/admin/book/view.jsp?id=" + book.get("id") %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                                <a href='<%= path + "/admin/book/edit.jsp?id=" + book.get("id") %>' class="btn btn-sm btn-success"><i class="fa fa-edit"></i></a>
                                <% if(deleted != null) { %>
                                    <button onclick="restoreBook(<%= book.get("id") %>)" class="btn btn-sm btn-danger"><i class="fa fa-undo"></i></button>
                                <% } else { %>
                                    <button onclick="deleteBook(<%= book.get("id") %>)" class="btn btn-sm btn-danger"><i class="fa fa-trash-alt"></i></button>
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
    $("#book-index").DataTable();
</script>
</html>