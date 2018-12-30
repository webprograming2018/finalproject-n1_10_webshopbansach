<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@page import="DAO.DAOUser"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="DAO.DAOInvoice" %>
<%@ page import="DAO.DAOUser" %>
<%@ page import="Model.User" %>
<%@ page import="Model.Invoice" %>
<%
    int invoice_id = Integer.parseInt(request.getParameter("id"));
    Invoice invoice = DAOInvoice.find(invoice_id);
    if (session.getAttribute("username") != null) {
        int user_id = Integer.parseInt(session.getAttribute("id").toString());
        int invoice_user_id = invoice.getUser_id();
        if(user_id != invoice_user_id) {
            response.sendRedirect(request.getContextPath() + "/invoice.jsp");
        }
        if(user_id != invoice_user_id);
    } else {
        response.sendRedirect(request.getContextPath());
    }
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
    <h2 class="text-primary">Your Invoice #
        <%= invoice_id %>
    </h2>
    <hr>
    <div class="container mb-5">
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
                    <span class="badge badge-<%= status == 1 ? " secondary" : (status==2 ? "primary" : (status==3 ?
                        "warning" : (status==4 ? "success" : "danger" ))) %> text-white">
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
        <table class="table table-stripped mt-3" id="book-invoice">
            <thead>
                <tr>
                    <th scope="row">#</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% for(Map<String, String> book : DAOInvoice.getBookInvoice(invoice_id)) { %>
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
    <!-- Footer -->
    <jsp:include page="./layout/footer.jsp" />
    <script src='<%= path + "/js/jspdf.min.js" %>'></script>
    <script src='<%= path + "/js/html2canvas.min.js" %>'></script>
</body>
<script>
    // Tieng viet sang tieng viet khong dau
    function convertName(str) {
        str = str.replace(/^\s+|\s+$/g, ''); // trim
        // str = str.toLowerCase();
        // remove accents, swap ñ for n, etc
        str = str.replace(/á|à|ả|ạ|ã|ă|ắ|ằ|ẳ|ẵ|ặ|â|ấ|ầ|ẩ|ẫ|ậ/gi, 'a');
        str = str.replace(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/gi, 'e');
        str = str.replace(/i|í|ì|ỉ|ĩ|ị/gi, 'i');
        str = str.replace(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/gi, 'o');
        str = str.replace(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/gi, 'u');
        str = str.replace(/ý|ỳ|ỷ|ỹ|ỵ/gi, 'y');
        str = str.replace(/đ/gi, 'd');
        return str;

    }

    // Datatable
    $("#book-invoice").DataTable({
        "searching": false,
        "lengthChange": false,
        "info": false
    });
    // Save invoice
    $("#print").click(function (e) {
        e.preventDefault();
        var pdf = new jsPDF({
            orientation: 'landscape'
        });
        var title = '<%= DAOUser.find(invoice.getUser_id()).getUsername() + "-order-" + invoice.getId() %>.pdf';
        pdf.setProperties({
            title: name
        });
        var text = '<h4>Order nmber: #<%= invoice.getId() %></h4>';
        text += "<h4>Username: <%= DAOUser.find(invoice.getUser_id()).getUsername() %></h4>";
        text += "<h4>Address: <%= invoice.getAddress() %></h4>";
        text += "<table style='width: 100%;font-size:9px'><thead><th>#</th><th>Name</th><th>Quantity</th><th>Price</th><th>Total</th></thead><tbody>";
        <% 
            for (Map < String, String > book : DAOInvoice.getBookInvoice(invoice_id)) {
                out.println("var name = convertName('" + book.get("name") + "');");
                out.println("text += '<tr>'");
                out.println("text += '<td>" + book.get("id") + "</td>'");
                out.println("text += '<td>' + name + '</td>'");
                out.println("text += '<td>" + book.get("invoice_quantity") + "</td>'");
                out.println("text += '<td>" + book.get("invoice_price") + "</td>'");
                out.println("text += '<td>" + Integer.parseInt(book.get("invoice_price")) * Integer.parseInt(book.get("invoice_quantity")) + "</td>'");
                out.println("text += '</tr>'");
            }
        %>
        text += "</tbody></table>";
        text += "<h3>Subtotal: <%= invoice.getTotal() %></h3>";
        text += "<h3>Ship: 10%</h3>";
        text += "<h3>Total: <%= invoice.getTotal() + invoice.getTotal()/10 %></h3>";
    pdf.fromHTML(text, 15, 20);
    pdf.save(title);
    });
    // Send email
    $("#email").click(function (e) {
        e.preventDefault();
        $.ajax({
            type: "post",
            url: '<%= path + "/invoiceMail" %>',
            data: { "invoice_id": <%= invoice_id %>},
            dataType: "json",
            success: function (response) {
                toastr.success("A mail has been sent to your email");
            },
            error: function (errors) {
                toastr.error("Something went wrong. Please try again later");
            }
        });
    });
</script>

</html>