<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    session.invalidate(); // Destroys the session
    response.sendRedirect("login.jsp"); // Redirects to login page
%>
</body>
</html>