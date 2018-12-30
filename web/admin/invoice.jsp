<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.DAOUser" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.DAOInvoice" %>
<%@ page import="Model.Invoice" %>
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
                <span>Invoice</span>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped" id="invoice-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Username</th>
                            <th scope="col">Total</th>
                            <th scope="col">Shipping</th>
                            <th scope="col">Status</th>
                            <th scope="col">Created</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Invoice invoice : DAOInvoice.getListInvoice()) { %>
                        <tr>
                            <th scope="row">
                                <%= invoice.getId() %>
                            </th>
                            <td>
                                <%= DAOUser.find(invoice.getUser_id()).getUsername() %>
                            </td>
                            <td>
                                <%= invoice.getTotal() %>
                            </td>
                            <td>
                                <%= invoice.getShip_tax() %>
                            </td>
                            <td>
                                    <% int status = invoice.getStatus(); %>
                                    <span class="badge badge-<%= status == 1 ? "secondary" : (status == 2 ? "primary" : (status == 3 ? "warning" : (status == 4 ? "success" : "danger"))) %> text-white">
                                        <%= status == 1 ? "Pending" : (status == 2 ? "Confirmed" : (status == 3 ? "Shipping" : (status == 4 ? "Success" : "Cancelled"))) %>
                                    </span>
                            </td>
                            <td>
                                <%= invoice.getCreated_at() %>
                            </td>
                            <td class="text-center">
                                <a href='<%= path + "/admin/invoice/view.jsp?id=" + invoice.getId() %>' class="btn btn-sm btn-primary"><i
                                        class="fa fa-eye"></i></a>
                                <button type="button" class="btn btn-sm btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-edit"></i>
                                </button>
                                <div class="dropdown-menu" style="cursor: pointer">
                                    <p class="dropdown-item" onclick="updateInvoice(<%= invoice.getId() %>, 1)" href="#">Pending</p>
                                    <p class="dropdown-item" onclick="updateInvoice(<%= invoice.getId() %>, 2)" href="#">Confirm</p>
                                    <p class="dropdown-item" onclick="updateInvoice(<%= invoice.getId() %>, 3)" href="#">Shipping</p>
                                    <p class="dropdown-item" onclick="updateInvoice(<%= invoice.getId() %>, 4)" href="#">Success</p>
                                </div>
                                <a href='<%= path + "/invoice/delete?id=" + invoice.getId() %>' class="btn btn-sm btn-danger"><i
                                    class="fa fa-trash-alt"></i></a>
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