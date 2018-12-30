<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.DAOUser" %>
<%@ page import="Model.User" %>
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
                <span>User</span>
                <a href='<%= path + "/admin/user/create.jsp" %>' class="btn btn-success btn-sm float-right">Add New
                    User</a>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped" id="user-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Username</th>
                            <th scope="col">Status</th>
                            <th scope="col">Email</th>
                            <th scope="col">Role</th>
                            <th scope="col">Created</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(User user : DAOUser.getListUser()) { %>
                        <tr>
                            <th scope="row">
                                <%= user.getId() %>
                            </th>
                            <td>
                                <%= user.getUsername() %>
                            </td>
                            <td>
                                <% String deleted_at = user.getDeleted_at(); %>
                                <span class="badge badge-<%= deleted_at != null ? "danger" : "success" %> text-white">
                                    <%= deleted_at != null ? "Deleted" : "Active" %>
                                </span>
                            </td>
                            <td>
                                <%= user.getEmail() %>
                            </td>
                            <td>
                                <%= user.getRole() == 1 ? "Admin" : "Customer" %>
                            </td>
                            <td>
                                <%= user.getCreated_at() %>
                            </td>
                            <td class="text-center">
                                <a href='<%= path + "/admin/user/show.jsp?id=" + user.getId() %>' class="btn btn-sm btn-primary"><i
                                        class="fa fa-eye"></i></a>
                                <a href='<%= path + "/admin/user/edit.jsp?id=" + user.getId() %>' class="btn btn-sm btn-success"><i
                                        class="fa fa-edit"></i></a>
                                <% if(deleted_at != null) { %>
                                <button onclick="restoreUser(<%= user.getId() %>)" class="btn btn-sm btn-danger"><i
                                        class="fa fa-undo"></i></button>
                                <% } else { %>
                                <button onclick="deleteUser(<%= user.getId() %>)" class="btn btn-sm btn-danger"><i
                                        class="fa fa-trash-alt"></i></button>
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
    $("#user-index").DataTable();
</script>

</html>