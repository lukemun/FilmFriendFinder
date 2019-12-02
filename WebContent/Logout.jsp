<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (request.getSession().getAttribute("loggedIn") != null) {  
		request.getSession().setAttribute("activeUser", null);
		request.getSession().setAttribute("loggedIn", null);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Logout</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<%@ include file="Navbar.jsp" %>
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4 mb-4">Logout</h1>
			<div class="col-12">You are now logged out.</div>
			<div class="col-12 mt-3">You can go to the <a href="HomePage.jsp">home page</a> or <a href="Login.jsp">log in</a> again.</div>

		</div> <!-- .row -->
	</div> <!-- .container -->

</body>
</html>