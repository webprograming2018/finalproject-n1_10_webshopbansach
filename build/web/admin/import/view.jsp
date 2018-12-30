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
    <title>Import</title>
</head>

<body>
    <%@ include file="../layout/header.jsp" %>
    <%
        Import imp = new Import();
        User user = new User();
        if(request.getParameter("id") != null) {
            imp = DAOImport.find(Integer.parseInt(request.getParameter("id")));
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/import.jsp");
        }
    %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Import</span>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p>Mã hóa đơn:
                            <%= imp.getId() %>
                        </p>
                        <p>Publisher:
                            <%= imp.getPublisher() %>
                        </p>
                        <p>Ngày tạo:
                            <%= imp.getCreated_at() %>
                        </p>
                    </div>
                </div>
                <hr>
                <table class="table table-bordered table-striped mt-3" id="invoice-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Quantity</th>
                            <th>More</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Map<String, String> book : DAOImport.getBookImport(imp.getId())) { %>
                        <tr>
                            <td>
                                <%= book.get("id") %>
                            </td>
                            <td>
                                <%= book.get("name") %>
                            </td>
                            <td>
                                <%= book.get("import_quantity") %>
                            </td>
                            <td scop="row" class="text-center">
                                <a href='<%= path + "/admin/book/view.jsp?id=" + book.get("id") %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                                <a href='<%= path + "/admin/book/edit.jsp?id=" + book.get("id") %>' class="btn btn-sm btn-success"><i class="fa fa-edit"></i></a>
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
    $("#invoice-index").DataTable({
        'searching': false,
        'lengthChange': false,
        'info': false
    });
</script>

</html>