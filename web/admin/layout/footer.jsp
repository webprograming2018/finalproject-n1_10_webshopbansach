<%-- 
    Document   : footer
    Created on : Dec 21, 2018, 11:47:19 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<footer id="footer" class="mt-5">
    <div class="jumbotron mb-0 text-center" style="height: 150px!important;">
        <h6>Copyright &copy; 2018</h6>
    </div>
</footer>
<script src='<%= path + "/js/jquery-3.3.1.min.js" %>'></script>
<script src='<%= path + "/js/bootstrap.bundle.js" %>'></script>
<script src='<%= path + "/js/toastr.min.js" %>'></script>
<script src='<%= path + "/js/datatables.js" %>'></script>
<script src='<%= path + "/js/app.js" %>'></script>