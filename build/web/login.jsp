<%-- 
    Document   : index
    Created on : Dec 13, 2018, 10:52:46 AM
    Author     : mito
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%
    if (session.getAttribute("username") != null) {
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", request.getContextPath() + "/index.jsp");
    }
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
        <h2 class="text-primary">Login</h2>
        <hr>
        <div class="container">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="text-center">
                        <%
                            if(request.getParameter("error") != null){
                                out.print("<p class='text-danger'>Sai tên đăng nhập hoặc mật khẩu </p>");
                            }
                            if(request.getParameter("register") != null) {
                                out.print("<p class='text-success'>Đăng kí thành công. Mời bạn đăng nhập</p>");
                            }
                        %>
                        <form action="<%= path + "/login" %>" method="post">
                            <div class="form-group">
                                <input type="text" name="username" class="form-control" placeholder="Username">
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" class="form-control" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary">Login</button>
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
