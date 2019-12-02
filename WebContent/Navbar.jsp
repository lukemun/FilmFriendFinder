<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
<div class="d-flex flex-grow-1">
	<a class="navbar-brand" href="HomePage.jsp"></a>
	<div class="w-100 text-right">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#mainNav">
			<span class="navbar-toggler-icon"></span>
		</button>
	</div>
</div>
<div class="collapse navbar-collapse flex-grow-1 text-right" id="mainNav">
	<ul class="navbar-nav ml-auto flex-nowrap">
		<li class="nav-item">
			<a class="nav-link" href="HomePage.jsp">Home</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="Projects.jsp">Available Projects</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="ProjectCreation.jsp">Post a Project</a>
		</li>
		<%
			// Need this attribute to be set by Login servlet 
			if (request.getSession().getAttribute("activeUser") == null) {
		%>
		<li class="nav-item">
			<a class="nav-link" href="Registration.jsp">Register</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="Login.jsp">Login</a>
		</li>
		<%
			}
			else {
		%>
		<li class="nav-item"><a class="nav-link" href="Profile.jsp">Profile</a>
		</li>
		<li class="nav-item"><a class="nav-link" href="Logout.jsp">Logout</a>
		</li>
		<%
			}
		%>
	</ul>
</div>
</nav>