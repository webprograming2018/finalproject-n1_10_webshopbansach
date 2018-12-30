<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="DAO.DAOUser" %>
<%@ page import="Model.Category" %>
<%
    if (session.getAttribute("username") != null) {
        //
    } else {
        response.sendRedirect(request.getContextPath());
    }
    int user_id = Integer.parseInt(session.getAttribute("id").toString());
%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>List Invoice</title>
</head>

<body>
    <%@ include file="./layout/header.jsp" %>
    <!-- Main -->
    <h2 class="text-primary">Your Favorite</h2>
    <hr>
    <div class="container mb-5">
        <table class="table table-stripped" id="user-invoice">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th>Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for(Category cat : DAOUser.favorites(user)) { %>
                <tr>
                    <td><%= cat.getId() %></td>
                    <td><%= cat.getName() %></td>
                    <td class="text-center">
                        <a href='<%= path + "/category.jsp?id=" +cat.getId() %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                            <a href='<%= path + "/unsubcat?id=" +cat.getId() %>' class="btn btn-sm btn-danger"><i class="fa fa-times"></i></a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <!-- Footer -->
    <jsp:include page="./layout/footer.jsp" />
</body>
<script>
    $("#user-invoice").DataTable();
</script>
</html>