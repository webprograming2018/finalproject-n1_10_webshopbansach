<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%
    if (session.getAttribute("username") != null) {
        //
    } else {
        response.sendRedirect(request.getContextPath());
    }
    int user_id = Integer.parseInt(session.getAttribute("id").toString());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%@ include file="./layout/header.jsp" %>
        <!-- Main -->
        <h2 class="text-primary">Change Password</h2>
        <hr>
        <div class="container">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="text-center">
                        <%
                            if(request.getParameter("error") != null){
                                out.print("<p class='text-danger'>Mật khẩu cũ không đúng hoặc mật khẩu mới không khớp</p>");
                            }
                            if(request.getParameter("success") != null) {
                                out.print("<p class='text-success'>Đổi mật khẩu thành công</p>");
                            }
                        %>
                        <form action="<%= path + "/changepass" %>" method="post">
                        
                            <div class="form-group">
                                <input type="password" name="oldpassword" class="form-control" placeholder="Your old password" required>
                            </div>
                            <div class="form-group">
                                <input type="password" name="newpassword" class="form-control" placeholder="Your new password" required>
                            </div>
                            <div class="form-group">
                                <input type="password" name="repassword" class="form-control" placeholder="Confirm your new password" required>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary">Change Password</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>
        <!-- Footer -->
        <jsp:include page="./layout/footer.jsp"/>
    </body>
</html>
