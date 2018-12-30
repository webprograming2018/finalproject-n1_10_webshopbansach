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
    data: {
        labels: [
            new Date(today).toLocaleString(),
            new Date(yesterday).toLocaleString(),
            new Date(two_days_ago).toLocaleString(),
            new Date(three_days_ago).toLocaleString(),
            new Date(four_days_ago).toLocaleString()
        ],
        datasets: [{
            label: 'Book sold in last 5 days',
            data: [{
                t: new Date(today),
                y: <%= DAODashboard.sold_chart().get("today") %>
                    },
            {
                t: new Date(yesterday),
                y: <%= DAODashboard.sold_chart().get("yesterday") %>
                    },
            {
                t: new Date(two_days_ago),
                y: <%= DAODashboard.sold_chart().get("two_days_ago") %>
                    },
            {
                t: new Date(three_days_ago),
                y: <%= DAODashboard.sold_chart().get("three_days_ago") %>
                    },
            {
                t: new Date(four_days_ago),
                y: <%= DAODashboard.sold_chart().get("four_days_ago") %>
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