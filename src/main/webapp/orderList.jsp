<%@ page import="org.example.demo3.book.BookOrderHistory" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Order List</title>
</head>
<body>
<h1>Order List</h1>
<table>
    <tr>
        <th>Order ID</th>
        <th>Action</th>
    </tr>
    <% List<BookOrderHistory> orderList = (List<BookOrderHistory>) request.getAttribute("orderList");
        for (BookOrderHistory order : orderList) { %>
    <tr>
        <td><%= order.getOrderId() %>
        </td>
        <td>
            <a href="orders?action=view&orderId=<%= order.getOrderId() %>">View Order</a>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
