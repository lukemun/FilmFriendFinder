<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="container-fluid navbar-dark bg-dark p-2">
	<div class="row">
		<div class="col-12 d-flex justify-content-end">
			<%
				// Need this attribute to be set by Login servlet 
				// Update hrefs when other .jsp's created
				if (request.getSession().getAttribute("activeUser") == null) {
			%>				
				<a class="p-2 text-right text-white" href="HomePage.jsp">Home</a>
				<a class="p-2 text-right text-white" href="">Available Projects</a>
				<a class="p-2 text-right text-white" href="">Post a Project</a>
				<a class="p-2 text-right text-white" href="Registration.jsp">Register</a>
				<a class="p-2 text-right text-white" href="Login.jsp">Login</a>

			<%
				}
				else {
			%>
				<a class="p-2 text-right text-white" href="HomePage.jsp">Home</a>
				<a class="p-2 text-right text-white" href="">Available Projects</a>
				<a class="p-2 text-right text-white" href="">Post a Project</a>
				<a class="p-2 text-right text-white" href="Profile.jsp">Profile</a>
				<a class="p-2 text-right text-white" href="Logout.jsp">Logout</a>
			<%
				}
			%> 
		</div>
	</div>
</nav>
