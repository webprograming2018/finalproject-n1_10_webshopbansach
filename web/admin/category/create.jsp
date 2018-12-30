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
                <span>Add New Category</span>
            </div>
            <div class="card-body">
                <form method="POST" action='<%= path + "/category/create" %>'accept-charset="UTF-8">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input name="name" type="text" class="form-control" id="name">
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
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
</body>

</html>