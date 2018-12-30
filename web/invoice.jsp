<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="DAO.DAOInvoice" %>
<%@ page import="Model.Invoice" %>
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
    <h2 class="text-primary">Your Invoice</h2>
    <hr>
    <div class="container mb-5">
        <table class="table table-stripped" id="user-invoice">
            <thead>
                <tr>
                    <th scope="row">#</th>
                    <th class="text-center">Quantity</th>
                    <th>Subtotal</th>
                    <th>Ship</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
                <% for(Invoice inv : DAOInvoice.findByUser(user_id)) { %>
                <tr>
                    <td><%= inv.getId() %></td>
                    <td class="text-center"><%= inv.getTotal_book() %></td>
                    <td><%= inv.getTotal() %></td>
                    <td><%= inv.getTotal()/10 %>đ</td>
                    <td>
                        <% int status = inv.getStatus(); %>
                        <span class="badge badge-<%= status == 1 ? "secondary" : (status == 2 ? "primary" : (status == 3 ? "warning" : (status == 4 ? "success" : "danger"))) %> text-white">
                            <%= status == 1 ? "Pending" : (status == 2 ? "Confirmed" : (status == 3 ? "Shipping" : (status == 4 ? "Success" : "Cancelled"))) %>
                        </span>
                    </td>
                    <td><%= inv.getTotal() + inv.getTotal()/10 %>đ</td>
                    <td class="text-center">
                        <a href='<%= path + "/invoice_view.jsp?id=" +inv.getId() %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                        <% if(status == 1 || status == 2) { %>
                            <a href='<%= path + "/invcancel?id=" +inv.getId() %>' class="btn btn-sm btn-danger"><i class="fa fa-times"></i></a>
                        <% } %>
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