<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.DAOBook" %>
<%@ page import="Model.Book" %>
<%@ page import="Model.Invoice" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.DAOUser" %>
<%
    int book_id = Integer.parseInt(request.getParameter("id"));
    if(DAOBook.findBook(book_id).getId() != 0) {
        //
    } else {
        response.sendRedirect(request.getContextPath() + "/admin/book.jsp");
    }
    Book book = DAOBook.findBook(book_id);
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
                <span>Book Info</span>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <img src='<%= path + "/images/book/" + book.getSlug() + ".gif" %>' alt="" width="100%">
                    </div>
                    <div class="col-md-9">
                        <p>Name:
                            <%= book.getName() %>
                        </p>
                        <p>Author:
                            <%= book.getAuthor() %>
                        </p>
                        <p>Category:
                            <%= DAOCategory.find(book.getCat_id()).getName() %>
                        </p>
                        <p>Price:
                            <%= book.getPrice() %>đ
                        </p>
                        <p>Total Quantity:
                            <%= book.getTotal_quantity() %>
                        </p>
                        <p>Quantity Left:
                            <%= book.getLeft_quantity() %>
                        </p>
                        <a href='<%= path + "/admin/book/edit.jsp?id=" + book.getId() %>' class="btn btn-primary"><i class="fa fa-edit"></i> Edit book</i></a>
                    </div>
                </div>
                <p class="text-mute mt-5">Invoices of this book</p>
                <table class="table table-stripped mt-2" id="book-info"> 
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th>User</th>
                            <th>Status</th>
                            <th>Address</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Invoice inv : DAOBook.invoices(book)) { %>
                            <tr>
                                <td><%= inv.getId() %></td>
                                <td><%= DAOUser.find(inv.getUser_id()).getUsername() %></td>
                                <td>
                                        <% int status = inv.getStatus(); %>
                                        <span class="badge badge-<%= status == 1 ? "secondary" : (status == 2 ? "primary" : (status == 3 ? "warning" : (status == 4 ? "success" : "danger"))) %> text-white">
                                            <%= status == 1 ? "Pending" : (status == 2 ? "Confirmed" : (status == 3 ? "Shipping" : (status == 4 ? "Success" : "Cancelled"))) %>
                                        </span>
                                </td>
                                <td><%= inv.getAddress() %></td>
                                <td><%= inv.getTotal() %></td>
                                <td class="text-center">
                                        <a href='<%= path + "/admin/invoice/view.jsp?id=" + inv.getId() %>' class="btn btn-sm btn-primary"><i
                                                class="fa fa-eye"></i></a>
                                        <button type="button" class="btn btn-sm btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <div class="dropdown-menu" style="cursor: pointer">
                                            <p class="dropdown-item" onclick="updateInvoice(<%= inv.getId() %>, 1)" href="#">Pending</p>
                                            <p class="dropdown-item" onclick="updateInvoice(<%= inv.getId() %>, 2)" href="#">Confirm</p>
                                            <p class="dropdown-item" onclick="updateInvoice(<%= inv.getId() %>, 3)" href="#">Shipping</p>
                                            <p class="dropdown-item" onclick="updateInvoice(<%= inv.getId() %>, 4)" href="#">Success</p>
                                        </div>
                                        <a href='<%= path + "/invoice/delete?id=" + inv.getId() %>' class="btn btn-sm btn-danger"><i
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
    <jsp:include page="../layout/footer.jsp" />
</body>
<script>
    $("#book-info").DataTable();
</script>

</html>