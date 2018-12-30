<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <span>Add New User</span>
            </div>
            <div class="card-body">
                <form method="POST" action='<%= path + "/user/create" %>' accept-charset="UTF-8">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input name="username" type="text" class="form-control" id="username" required>
                    </div>
                    <div class="form-group">
                        <label for="author">Email</label>
                        <input name="email" type="email" class="form-control" id="email" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input name="password" type="password" class="form-control" id="password" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="repassword">Confirm Password</label>
                                <input name="repassword" type="password" class="form-control" id="repassword" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input name="address" type="text" class="form-control" id="address" required>
                    </div>
                    <div class="form-group">
                        <label for="role">Role</label>
                        <select class="form-control" name="role" id="role" required>
                            <option value="1">Admin</option>
                            <option value="2">Customer</option>
                        </select>
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
        if(request.getParameter("password") != null) {
            out.print("<script> toastr.error('Password does not match!') </script>");
        }
        if(request.getParameter("error") != null) {
            out.print("<script> toastr.error('Something went wrong!') </script>");
        }
    %>
</body>

</html>