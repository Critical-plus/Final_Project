<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<body>
<c:set var="email" value ="<%=request.getParameter(\"email\") %>" />
<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/student?characterEncoding=utf-8&serverTimezone=UTC" user="root"  password="Wu-Yu-Xuan"/>
<sql:query dataSource="${snapshot}" var="result">
    SELECT password from account where email= ?;
    <sql:param value ="${email}"/>
</sql:query>
<c:forEach var="row" items="${result.rows}" begin="0" end="1">
    <c:set var="column_1" value="${row.password}"/>
</c:forEach>
<%
    String Password = (String)pageContext.getAttribute("column_1");
    String mypassword = request.getParameter("password");
    if (Password.equals(mypassword)) {
        String site = new String ("http://localhost:8035/home.html");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
    }else {
        String site = new String ("http://localhost:8035/LoginPage.html");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
    }
%>
</body>
</html>