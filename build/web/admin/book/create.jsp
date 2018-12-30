<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAOCategory" %>
<%@ page import="Model.Category" %>
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
                <span>Book</span>
            </div>
            <div class="card-body">
                <form method="POST" action='<%= path + "/book/create" %>' enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input name="name" type="text" class="form-control" id="name">
                        <input name="slug" type="hidden" class="form-control" id="slug">
                    </div>
                    <div class="form-group">
                        <label for="author">Author</label>
                        <input name="author" type="text" class="form-control" id="author">
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="cat_id">Category</label>
                                <select class="form-control" name="cat_id" id="cat_id">
                                    <% for(Category c : DAOCategory.getListCategory()) { %>
                                    <option value="<%= c.getId() %>"><%= c.getName() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="image">Image</label>
                                <input name="image" type="file" class="form-control-file" id="image">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="total_quantity">Quantity</label>
                                <input type="number" class="form-control" name="total_quantity" id="total_quantity">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="price">Price</label>
                                <input type="number" class="form-control" name="price" id="price">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea name="des" class="form-control" id="description" rows="3"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
    </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <%
        if(request.getParameter("error") != null) {
            out.print("<script> toastr.error('Something went wrong!') </script>");
        }
    %>
    <script>
        $("#name").keyup(function () { 
            var str = $(this).val();
            str = str.replace(/^\s+|\s+$/g, ''); // trim
            str = str.toLowerCase();
        
            // remove accents, swap ñ for n, etc
            str = str.replace(/á|à|ả|ạ|ã|ă|ắ|ằ|ẳ|ẵ|ặ|â|ấ|ầ|ẩ|ẫ|ậ/gi, 'a');
            str = str.replace(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/gi, 'e');
            str = str.replace(/i|í|ì|ỉ|ĩ|ị/gi, 'i');
            str = str.replace(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/gi, 'o');
            str = str.replace(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/gi, 'u');
            str = str.replace(/ý|ỳ|ỷ|ỹ|ỵ/gi, 'y');
            str = str.replace(/đ/gi, 'd');
            str = str.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
                .replace(/\s+/g, '-') // collapse whitespace and replace by -
                .replace(/-+/g, '-'); // collapse dashes

            $("#slug").val(str);
            
        });
    </script>
</body>

</html>