<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAOCategory" %>
<%@ page import="Model.Category" %>
<%
  if(request.getParameter("id") == null) {
      response.sendRedirect(request.getContextPath() + "/admin/category.jsp");
  }
  int id = Integer.parseInt(request.getParameter("id"));
  Category cat = DAOCategory.find(id);
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
                <span>Add New Category</span>
            </div>
            <div class="card-body">
                <form method="POST" action='<%= path + "/category/edit" %>'accept-charset="UTF-8">
                    <input name="id" type="hidden" value="<%= id %>">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input name="name" type="text" class="form-control" id="name" value="<%= cat.getName() %>">
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