<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.DAOUser" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.DAOImport" %>
<%@ page import="Model.Import" %>
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
                <span>Import</span>
                <a href='<%= path + "/admin/import/create.jsp" %>' class="btn btn-success btn-sm float-right">Add New Import</a>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped" id="invoice-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Publisher</th>
                            <th scope="col">Status</th>
                            <th scope="col">Note</th>
                            <th scope="col">Created</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Import imp : DAOImport.getListImport()) { %>
                        <tr>
                            <th scope="row">
                                <%= imp.getId() %>
                            </th>
                            <td>
                                <%= imp.getPublisher() %>
                            </td>
                            <td>
                                <% String deleted_at = imp.getDeleted_at(); %>
                                    <span class="badge badge-<%= deleted_at != null ? "danger" : "success" %> text-white">
                                        <%= deleted_at != null ? "Deleted" : "Active" %>
                                    </span>
                            </td>
                            <td>
                                <%= imp.getNote() %>
                            </td>
                            <td>
                                <%= imp.getCreated_at() %>
                            </td>
                            <td class="text-center">
                                <a href='<%= path + "/admin/import/view.jsp?id=" + imp.getId() %>' class="btn btn-sm btn-primary"><i
                                        class="fa fa-eye"></i></a>
                                <% if(deleted_at != null) { %>
                                    <button onclick="restoreImport(<%= imp.getId() %>)" class="btn btn-sm btn-danger"><i class="fa fa-undo"></i></button>
                                <% } else { %>
                                    <button onclick="deleteImport(<%= imp.getId() %>)" class="btn btn-sm btn-danger"><i class="fa fa-trash-alt"></i></button>
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
    $("#invoice-index").DataTable();
</script>

</html>