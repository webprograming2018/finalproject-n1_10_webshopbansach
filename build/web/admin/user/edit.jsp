<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAOUser" %>
<%@ page import="Model.User" %>
<% 
    if(request.getParameter("id") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/user.jsp");
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book</title>
</head>

<body>
    <%@ include file="../layout/header.jsp" %>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        User user = DAOUser.find(id);

    %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Add New User</span>
            </div>
            <div class="card-body">
                <form method="POST" action='<%= path + "/user/edit" %>' accept-charset="UTF-8">
                    <input name="id" type="hidden" value="<%= user.getId() %>">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input name="username" type="text" class="form-control" id="username" value="<%= user.getUsername() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input name="email" type="email" class="form-control" id="email" value="<%= user.getEmail() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input name="address" type="text" class="form-control" id="address" value="<%= user.getAddress() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="role">Role</label>
                        <select class="form-control" name="role" id="role">
                            <option value="1" <%= user.getRole() == 1 ? "selected" : "" %>>Admin</option>
                            <option value="2" <%= user.getRole() == 2 ? "selected" : "" %>>Customer</option>
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