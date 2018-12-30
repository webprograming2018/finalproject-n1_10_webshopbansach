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
    <%@ include file="../layout/header.jsp" %>
    <%
        Invoice invoice = new Invoice();
        User user = new User();
        if(request.getParameter("id") != null) {
            invoice = DAOInvoice.find(Integer.parseInt(request.getParameter("id")));
            user = DAOInvoice.user(invoice);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/invoice.jsp");
        }
    %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Invoice</span>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p>Mã hóa đơn:
                            <%= invoice.getId() %>
                        </p>
                        <p>Người mua:
                            <%= DAOUser.find(invoice.getUser_id()).getUsername() %>
                        </p>
                        <p>Địa chỉ:
                            <%= invoice.getAddress() %>
                        </p>
                        <p>Trạng thái:
                            <% int status = invoice.getStatus(); %>
                            <span class="badge badge-<%= status == 1 ? " secondary" : (status==2 ? "primary" : (status==3
                                ? "warning" : (status==4 ? "success" : "danger" ))) %> text-white">
                                <%= status == 1 ? "Pending" : (status == 2 ? "Confirmed" : (status == 3 ? "Shipping" : (status == 4 ? "Success" : "Cancelled"))) %>
                            </span></p>
                        <p>Ngày tạo:
                            <%= invoice.getCreated_at() %>
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <button id="print" class="btn btn-primary"><i class="fa fa-print"></i> Print</button>
                        <button id="email" class="btn btn-danger"><i class="fa fa-envelope"></i> Send Email</button>
                    </div>
                </div>
                <hr>
                <table class="table table-bordered table-striped mt-3" id="invoice-index">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">QUantity</th>
                            <th scope="col">Price</th>
                            <th scope="col">Subtotal</th>
                            <th>More</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Map<String, String> book : DAOInvoice.getBookInvoice(invoice.getId())) { %>
                        <tr>
                            <td>
                                <%= book.get("id") %>
                            </td>
                            <td>
                                <%= book.get("name") %>
                            </td>
                            <td>
                                <%= book.get("invoice_quantity") %>
                            </td>
                            <td>
                                <%= book.get("invoice_price") %>
                            </td>
                            <td>
                                <%= Integer.parseInt(book.get("invoice_price"))*Integer.parseInt(book.get("invoice_quantity")) %>
                            </td>
                            <td scop="row" class="text-center">
                                <a href='<%= path + "/admin/book/view.jsp?id=" + book.get("id") %>' class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a>
                                <a href='<%= path + "/admin/book/edit.jsp?id=" + book.get("id") %>' class="btn btn-sm btn-success"><i class="fa fa-edit"></i></a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <table class="table table-stripped mt-5" id="invoice">
                    <tbody>
                        <tr>
                            <td colspan="4" class="text-right">Subtotal</td>
                            <td>
                                <%= invoice.getTotal() %>đ</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-right">Ship</td>
                            <td>
                                <%= invoice.getShip_tax() %>%</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-right">Total</td>
                            <td>
                                <%= invoice.getTotal() + invoice.getTotal()/invoice.getShip_tax() %>đ</td>
                        </tr>
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