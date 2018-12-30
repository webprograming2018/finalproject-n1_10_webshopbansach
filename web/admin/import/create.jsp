<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAOBook" %>
<%@ page import="Model.Book" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Import</title>
</head>

<body>
    <%@ include file="../layout/header.jsp" %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Add New Import</span>
            </div>
            <div class="card-body">
                <form method="POST" action='<%= path + "/category/create" %>' accept-charset="UTF-8">
                    <div class="form-group">
                        <label for="publisher">Publisher</label>
                        <input name="publisher" type="text" class="form-control" id="publisher">
                    </div>
                    <div class="form-group">
                        <label for="note">Publisher</label>
                        <textarea name="note" id="note" cols="30" rows="5" class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="book">Book</label>
                        <select name="book" id="book-import" class="form-control" multiple="multiple">
                            <% for(Map<String, String> book : DAOBook.getListBook()) { %>
                            <option value="<%= book.get("id") %>">
                                <%= book.get("name") %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <div id="book-list-show">
                        
                    </div>
                    <button type="submit" id="submit" class="btn btn-primary mt-5">Save</button>
                </form>
            </div>
        </div>
    </div>
    </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script src='<%= path + "/js/select2.min.js" %>'></script>
</body>
<script>
    // All book
    var all_books = [];
    var cart = [];
    $.ajax({
        type: "get",
        url: "<%= path %>/import/select",
        data: "data",
        dataType: "json",
        success: function (response) {
            all_books = response;
        }
    });
    var prev_list = "";
    function matchCustom(params, data) {
        // If there are no search terms, return all of the data
        if ($.trim(params.term) === '') {
            return data;
        }

        // Do not display the item if there is no 'text' property
        if (typeof data.text === 'undefined') {
            return null;
        }

        // `params.term` should be the term that is used for searching
        // `data.text` is the text that is displayed for the data object
        if (data.text.indexOf(params.term) > -1) {
            var modifiedData = $.extend({}, data, true);
            modifiedData.text += ' (matched)';

            // You can return modified objects from here
            // This includes matching the `children` how you want in nested data sets
            return modifiedData;
        }

        // Return `null` if the term should not be displayed
        return null;
    }
    $("#book-import").select2({
        multiple: true,
        closeOnSelect: false,
        matcher: matchCustom,
        placeholder: 'Select books..'
    }).on("change", function () {
        var cur_list = $("#book-import").val();
        if(cur_list.length > prev_list.length) {
            var list = cur_list.filter(item => {
                return !prev_list.includes(item);
            })
            prev_list = cur_list;
            var tmp = all_books.filter(book => {
                return list.includes(book.id.toString());
            })
            var tmp_book = {
                "id": tmp[0].id,
                "name": tmp[0].name,
                "slug": tmp[0].slug,
                "quantity": 1,
            }
            cart.push(tmp_book);
        } else {
            cart = cart.filter(book => {
                return cur_list.includes(book.id.toString());
            })
            prev_list = cur_list;
        }
        
        // render book selected in import
        var text = '<div class="row">';
        cart.forEach(book => {
            text += '<div class="col-md-6 mt-2">';
            text += '<div class="row">';
            text += '<div class="col-md-2 text-center">';
            text += '<img src="' + context_path + '/images/book/' + book.slug + '.gif" alt="" width="80" height="134">';
            text += '</div>';
            text += '<div class="col-md-8 ml-5">';
            text += '<span>' + book.name + '</span>';
            text += '<input type="text" class="form-control" onkeyup="changeQuantity(this,' + book.id + ')" value="1">';
            text += '</div>';
            text += '</div>';
            text += '</div>';
        })
        $("#book-list-show").html(text);
    })

    function changeQuantity(self, book_id) {
        cart.forEach(book => {
            if(book.id.toString() == book_id.toString()) {
                book.quantity = self.value;
            }
        })
    }

    // Form data
    var publisher = "";
    $("#publisher").keyup(function () {
        publisher = $(this).val();
    })
    var note = "";
    $("#note").keyup(function () {
        note = $(this).val();
    });
    $("#submit").click(function (e) {
        e.preventDefault();
        $.ajax({
            type: "post",
            url: context_path + "/import/create",
            data: {"publisher" : publisher, "note": note, "cart": JSON.stringify(cart)},
            dataType: "json",
            success: function (response) {
                toastr.success(response);
                setTimeout(() => {
                    window.location.href = context_path + "/admin/import.jsp"; 
                }, 2000);
            }
        });
    })
</script>

</html>