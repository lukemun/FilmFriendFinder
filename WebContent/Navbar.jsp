<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="container-fluid bg-light p-2">
	<div class="row">
		<div class="col-12 d-flex justify-content-end">
			<%
				if (request.getSession().getAttribute("activeUser") == null) {
			%>				
				<a class="p-2 text-right" href="Login.jsp">Login</a>
				<a class="p-2 text-right" href="Registration.jsp">Register</a>

			<%
				}
				else {
			%>
				<a class="p-2 text-right" href="Profile.jsp">Profile</a>
				<a class="p-2 text-right" href="Logout.jsp">Logout</a>
			<%
				}
			%> 
		</div>
	</div>
</nav>
