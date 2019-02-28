<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Seong Jin
  Date: 2019-02-20
  Time: 오전 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Statistics</h1>
        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
    </div>

    <!-- Content Row -->

    <div class="row">

        <form aciton="chart" method="post">
            <input type = "text" name="startDate" >
        </form>
       <script>

            window.onload = function () {

                var chart = new CanvasJS.Chart("chartContainer", {
                    animationEnabled: true,
                    theme: "light2",
                    title: {
                        text: "total statistics"
                    },
                    axisX: {
                        valueFormatString: "DD MMM",
                        crosshair: {
                            enabled: true,
                            snapToDataPoint: true
                        }
                    },
                    axisY: {
                        logarithmic: true, //change it to false
                        title: "Sales(won)",
                        titleFontColor: "#6D78AD",
                        lineColor: "#6D78AD",
                        gridThickness: 0,
                        lineThickness: 1,
                        includeZero: false
                    },
                    axisY2: {
                        title: "order",
                        titleFontColor: "#51CDA0",
                        logarithmic: false, //change it to true
                        lineColor: "#51CDA0",
                        gridThickness: 0,
                        lineThickness: 1
                    },
                    toolTip: {
                        shared: true
                    },
                    legend: {
                        cursor: "pointer",
                        verticalAlign: "top",
                        dockInsidePlotArea: true,
                        horizontalAlign: "left",
                    },
                    data: [{
                        type: "line",
                        yValueFormatString: "000##",
                        xValueFormatString: "MM-DD",
                        showInLegend: true,
                        name: "Sales",
                        legendText: "{name}",
                        dataPoints: [
                            <c:forEach items="${list}" var="statistics" varStatus="state">
                            { x: new Date(<c:out value="${statistics.startDate}" />),
                                y: <c:out value="${statistics.totalSales}" /> }
                            <c:if test="${state.last eq false}">,</c:if>
                            </c:forEach>
                        ]
                         },
                        {
                            type: "line",
                            yValueFormatString: "###0",
                            xValueFormatString: "MM-DD",
                            axisYType: "secondary",
                            showInLegend: true,
                            name: "Order",
                            legendText: "{name}",
                            dataPoints: [
                                <c:forEach items="${list}" var="statistics" varStatus="state">
                                { x: new Date(<c:out value="${statistics.startDate}" />),
                                    y: <c:out value="${statistics.orderCnt}" /> }
                                <c:if test="${state.last eq false}">,</c:if>
                            </c:forEach>
                            ]
                        }]
                });
                chart.render();

            }

            window.onload = function() {

                var chart = new CanvasJS.Chart("chartContainer", {
                    animationEnabled: true,
                    title: {
                        text: "products statistics"
                    },

                    axisX: {
                        title: "product"
                    },
                    data: [{
                        type: "column",
                        yValueFormatString: "#,##0\"",
                        dataPoints:[
                            <c:forEach items="${list}" var="statistics" varStatus="state">
                            { label: <c:out value="${statistics.startDate}" />,
                                y: <c:out value="${statistics.totalSales}" /> }
                            <c:if test="${state.last eq false}">,</c:if>
                            </c:forEach>
                        ]
                    }]
                });
                chart.render();

            }
       </script>
        <div id="chartContainer" style="height: 300px; width: 100%;"></div>
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

    </div>





<%@include file="../includes/footer.jsp" %>