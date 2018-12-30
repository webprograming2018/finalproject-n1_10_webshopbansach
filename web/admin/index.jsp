<%-- 
    Document   : index
    Created on : Dec 21, 2018, 11:43:02 AM
    Author     : mito
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DAODashboard" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard</title>
</head>

<body>
    <%@ include file="./layout/header.jsp" %>
    <div class="col-md-9">
        <div class="card">
            <div class="card-header main-color-bg">
                <span>Overview</span>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-primary text-white">
                                <i class="fa fa-user"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    User
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("user_count") %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-success text-white">
                                <i class="fa fa-book"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    Book
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("book_count") %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-warning text-white">
                                <i class="fa fa-align-justify"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    Category
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("category_count") %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-info text-white">
                                <i class="fa fa-receipt"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    Invoice
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("invoice_count") %>
                                </span>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-primary text-white">
                                <i class="fa fa-book"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    Sold books
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("total_sold_books") %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-success text-white">
                                <i class="fa fa-money-check-alt"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    Total Money
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("total_money") %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-warning text-white">
                                <i class="fa fa-book"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">
                                    Left book
                                </span>
                                <span class="info-box-number">
                                    <%= DAODashboard.counter().get("total_left_books") %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-info text-white">
                                    <i class="fa fa-download"></i>
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">
                                        Import
                                    </span>
                                    <span class="info-box-number">
                                        <%= DAODashboard.counter().get("import_count") %>
                                    </span>
                                </div>
                            </div>
                        </div>
                </div>

                <div class="col-md-12 mt-5">
                    <canvas id="myChart"></canvas>
                </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
    <jsp:include page="./layout/footer.jsp" />
    <script src="../js/Chart.bundle.min.js"></script>
    <script>
        var day = new Date().getDate();
        var month = new Date().getMonth() + 1;
        var year = new Date().getFullYear();
        // today
        var today = year + "-" + month + "-" + day;
        // yesterday
        var yesterday = year + "-" + month + "-" + (day - 1);
        // 2 days ago
        var two_days_ago = year + "-" + month + "-" + (day - 2);
        // 3 days ago
        var three_days_ago = year + "-" + month + "-" + (day - 3);
        // 4 days ago
        var four_days_ago = year + "-" + month + "-" + (day - 4);
        var chart = $("#myChart");
        var myChart = new Chart(chart, {
            type: 'line',
            options: {
                legends: {display: false},
            },
            data: {
                labels: [
                    new Date(four_days_ago).toDateString(),
                    new Date(three_days_ago).toDateString(),
                    new Date(two_days_ago).toDateString(),
                    new Date(yesterday).toDateString(),
                    new Date(today).toDateString()
                ],
                datasets: [{
                    label: 'Book sold in last 5 days',
                    data: [
                        {
                            t: new Date(four_days_ago),
                            y: <%= DAODashboard.sold_chart().get("four_days_ago") %>
                        },
                        {
                            t: new Date(three_days_ago),
                            y: <%= DAODashboard.sold_chart().get("three_days_ago") %>
                        },
                        {
                            t: new Date(two_days_ago),
                            y: <%= DAODashboard.sold_chart().get("two_days_ago") %>
                        },
                        {
                            t: new Date(yesterday),
                            y: <%= DAODashboard.sold_chart().get("yesterday") %>
                        },
                        {
                            t: new Date(today),
                            y: <%= DAODashboard.sold_chart().get("today") %>
                        },
                    ],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            }
        });
    </script>
</body>

</html>