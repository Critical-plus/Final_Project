<%--
  Created by IntelliJ IDEA.
  User: Critical
  Date: 2020/12/29
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
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
<c:set var="password" value ="<%=request.getParameter(\"password\") %>" />
<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/student?characterEncoding=utf-8&serverTimezone=UTC" user="root"  password="Wu-Yu-Xuan"/>
<sql:update dataSource="${snapshot}" var="count">
    INSERT INTO account VALUES ("${email}","${password}");
</sql:update>
<%
    String site = new String ("http://localhost:8035/LoginPage.html");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
%>
</body>
</html>