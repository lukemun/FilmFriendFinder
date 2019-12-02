<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<title>Profile</title>
</head>
<body>
	<%@ include file="Navbar.jsp" %>
	
	<%
		// Need this attribute to be set by Login servlet 
		if (request.getSession().getAttribute("activeUser") != null) {
	%>	
	
	<div class="row justify-content-center">
		<h2 class="col-12 mt-2 mb-2 text-center">Your Profile</h2>
	</div>

	<hr>
	<br>
	
	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-12 mt-2 mb-2 text-center">In-Progress Projects</h3>
		</div>
		<div class="row justify-content-center">
			<div class="col-auto">
				<table class="table table-hover table-responsive mt-4">
						<thead>
							<tr>
								<th>Project Name</th>
								<th>Role</th>
								<th>Date Applied</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<a></a>
								</td>
								<td>
									
								</td>
								<td>
									
								</td>
								<td class="ml-1 mr-1">
									<a href=""class="btn btn-outline-primary">
									View </a>
								</td>
							</tr>
						</tbody>
					</table>
			</div>
		</div>
	</div>
		
	<hr>
	<br>

	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-12 mt-2 mb-2 text-center">Projects Applied To</h3>
		</div>
		<div class="row justify-content-center">
			<div class="col-auto">
				<table class="table table-hover table-responsive mt-4">
						<thead>
							<tr>
								<th>Project Name</th>
								<th>Role</th>
								<th>Date Applied</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<a></a>
								</td>
								<td>
									
								</td>
								<td>
									
								</td>
								<td>
									<a href=""class="btn btn-outline-danger" onclick="return confirm('Are you sure you want to withdraw your application?');">
									Cancel </a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
	</div>
	
	<hr>
	<br>

	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-12 mt-2 mb-2 text-center">Completed Projects</h3>
		</div>
		<div class="row justify-content-center">
			<div class="col-auto">
				<table class="table table-hover table-responsive mt-4">
						<thead>
							<tr>
								<th>Project Name</th>
								<th>Role</th>
								<th>Date Applied</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<a></a>
								</td>
								<td>
									
								</td>
								<td>
									
								</td>
								<td>
									<a href=""class="btn btn-outline-primary">
									View </a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
		</div>
	</div>

	<%
	}
	else {
	%>
		<div class="row justify-content-center">
			<h2 class="col-12 mt-2 mb-2 text-center">You are not logged in</h2>
		</div>
	<%
		}
	%> 

</body>

</html>