<%-- 
    Document   : footer
    Created on : Dec 16, 2018, 2:54:54 PM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
</div>
<footer class="blog-footer">
    <p>
        Copyright @ Nhóm 11
    </p>
    <p>
        <a href="https://getbootstrap.com/docs/4.0/examples/blog/#">Back to top</a>
    </p>
</footer>
<script src='<%= path + "/js/jquery-3.3.1.min.js" %>'></script>
<script src='<%= path + "/js/bootstrap.bundle.js" %>'></script>
<script src='<%= path + "/js/toastr.min.js" %>'></script>
<script src='<%= path + "/js/datatables.js" %>'></script>
<script src="https://js.pusher.com/4.3/pusher.min.js"></script>
<script src='<%= path + "/js/app.js" %>'></script>