<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cart</title>
</head>

<body>
    <%@ include file="./layout/header.jsp" %>
    <!-- Main -->
    <h2 class="text-primary">Cart</h2>
    <hr>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="text-center">
                    <table class="table table-striped" id="book-index">
                        <thead>
                            <tr>
                                <th></th>
                                <th scope="col">#</th>
                                <th scope="col">Book</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col">Total</th>
                            </tr>
                        </thead>
                        <tbody id="cart-table-body">

                        </tbody>
                        <tfoot>
                            <tr>
                                <td class="text-right" colspan="5">Total</td>
                                <td id="subtotal">0</td>
                            </tr>
                            <tr>
                                <td class="text-right" colspan="5">Shipping tax</td>
                                <td id="ship">10%</td>
                            </tr>
                            <tr>
                                <td class="text-right" colspan="5">Total</td>
                                <td id="total">0</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-md-4 text-right">
                <button id="save_invoice" class="btn btn-info">Save Invoice</button>
            </div>
            <div class="col-md-4 text-center">
                <button id="send_email" class="btn btn-success">Send Email</button>
            </div>
            <div class="col-md-4 text-left">
                <button id="checkout" class="btn btn-danger">Checkout</button>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    <!-- Footer -->
    <jsp:include page="./layout/footer.jsp" />
</body>
<script>
    var invoice = [];
    $(document).ready(function () {
        $.ajax({
            type: "get",
            url: '<%= path + "/loadCart" %>',
            data: "data",
            dataType: "json",
            success: function (response) {
                var cart = response;
                var subtotal = 0;
                response.forEach(book => {
                    var tmp = {
                        "id": book.id,
                        "name": book.name,
                        "price": book.price,
                        "invoice_quantity": 1,
                        "total": book.price,
                    };
                    subtotal += book.price;
                    invoice.push(tmp);
                });
                var text = "";
                invoice.forEach((book, index) => {
                    text += "<tr>";
                    text += "<td><button class='btn btn-sm btn-danger' onclick='remove(" + book.id + ")'><i class='fa fa-times'></i></button></td>";
                    text += "<td scope='row'>" + (index + 1) + "</td>";
                    text += "<td>" + book.name + "</td>";
                    text += "<td class='text-center'>";
                    text += "<button id='subtract' onclick='change(" + book.id + ",-1)' class='btn btn-sm btn-secondary'><i class='fa fa-minus'></i></button>";
                    text += "<span class='ml-5 mr-5' id='cart-book-" + book.id + "'>" + book.invoice_quantity + "</span>";
                    text += "<button id='plus' onclick='change(" + book.id + ",1)' class='btn btn-sm btn-secondary'><i class='fa fa-plus'></i></button>";
                    text += "</td>";
                    text += "<td>" + book.price + "</td>";
                    text += "<td id='cart-book-total-" + book.id + "'>" + book.total + "</td>";
                    text += "</tr>";
                });
                $("#cart-table-body").append(text);
                $("#subtotal").html(subtotal);
                $("#total").html(subtotal + subtotal*0.1);
            }
        });
    });
    function change(book_id, value) {
        var target = "#cart-book-" + book_id;
        var invoice_quantity = Number($(target).html()) + value;
        if(invoice_quantity < 1) {
            return;
        }
        $(target).html(invoice_quantity);
        var subtotal = 0;
        invoice.forEach(book => {
            if(book.id == book_id) {
                book.invoice_quantity = invoice_quantity;
                book.total = book.invoice_quantity * book.price;
                $("#cart-book-total-" + book.id).html(book.total);
            }
            subtotal += book.total;
        });
        $("#subtotal").html(subtotal);
        $("#total").html(subtotal + subtotal*0.1);  
    }
    $("#checkout").click(function () {
        var post_invoice = [];
        invoice.forEach(book => {
            var tmp = {
                "id" : book.id,
                "invoice_quantity": book.invoice_quantity
            }
            post_invoice.push(tmp);
        });
        $.ajax({
            type: "POST",
            url: '<%= path + "/checkout" %>',
            data: {"cart" : JSON.stringify(post_invoice)},
            dataType: "json",
            success: function (response) {
                toastr.success("Your order has been created. Check it in your invoice");
                setTimeout(function () {
                    window.location.replace('<%= path + "/invoice.jsp" %>');
                }, 2000);
            },
            error: function (errors) {
                toastr.error(errors.responseText);
            }
        });
    })
    function remove(book_id) {
        $.ajax({
            type: "get",
            url: '<%= path + "/updateCart" %>',
            dataType: "json",
            success: function (response) {
                var list = response.split(",");
                var updated_cart = list.filter(book => {
                    return !(book_id == Number(book));
                });
                var string_cart = updated_cart.join(",");
                $.ajax({
                    type: "post",
                    url: '<%= path + "/updateCart"%>',
                    data: {"cart": string_cart},
                    dataType: "json",
                    success: function (response) {
                        window.location.reload();
                    }
                });
            }
        });
    }
</script>
</html>