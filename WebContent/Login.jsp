<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

	<%
	String error = null;
	String result = null;
	
	if (request.getSession().getAttribute("loggedIn") != null) {  
		response.sendRedirect("HomePage.jsp");
	}
	else {
		if ( request.getParameter("uname") != null && request.getParameter("pwd") != null) {
			if ( request.getParameter("uname").isEmpty() || request.getParameter("pwd").isEmpty()) {
				error = "Please enter your email and password.";
			}
			else {
				Connection conn = null;
				PreparedStatement sqlLogin = null;
				ResultSet resultsLogin = null;
				
				try  {
					Class.forName("com.mysql.jdbc.Driver");  
					conn = DriverManager.getConnection("jdbc:mysql://google/fff"
							+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
							+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
							+ "&useSSL=false"
							+ "&user=root"
							+ "&password=root");
					
					sqlLogin = conn.prepareStatement("SELECT password FROM User WHERE email = ? AND password = ?");
					sqlLogin.setString(1, request.getParameter("uname"));
					sqlLogin.setString(2, request.getParameter("pwd"));
		
					resultsLogin = sqlLogin.executeQuery();
								
					if (resultsLogin.next()) {
						result = "Logged in!";
						request.getSession().setAttribute("loggedIn", true);
						request.getSession().setAttribute("activeUser", request.getParameter("uname"));
						response.sendRedirect("HomePage.jsp");
					} else {
						error = "Username or password incorrect. Please try again.";
					}
				} catch (SQLException sqle) {
					System.out.println("SQLE ERROR" + sqle.getMessage());
					sqle.printStackTrace();
				} catch (ClassNotFoundException cnfe) {
					System.out.println("CNFE ERROR" + cnfe.getMessage());
					cnfe.printStackTrace();
				} finally {
					try {
		 				if (resultsLogin != null) {
		 					resultsLogin.close();
						}
		 				if (sqlLogin != null) {
		 					sqlLogin.close();
						}
						if (conn != null) {
							conn.close();
						}
					} catch (SQLException sqle) {
						System.out.println(sqle.getMessage());
					}
				}
			}
		}
	}
	%>   
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<title>Login</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4 mb-4">Login</h1>
		</div>
	</div>
	<div class="container">
		<form action="Login.jsp" method="POST" class="needs-validation" novalidate>
			<div class="row mb-3">
				<div class="font-italic text-danger col-sm-9 ml-sm-auto">
					<!-- Show errors here. -->
					<%
						if (error != null) {
					%>
						<%= error %>
					<%
						}
					%>
				</div>
			</div> <!-- .row -->
		
			<div class="form-group">
    			<label for="uname">Email</label>
    			<input type="email" class="form-control" id="uname" name="uname" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter email.</div>
  			</div>
  			<div class="form-group">
    			<label for="pwd">Password</label>
    			<input type="password" class="form-control" id="pwd" name="pwd" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter password.</div>
  			</div>
  			<button type="submit" class="btn btn-dark">Login</button>
  			<a href="${header.referer}" role="button" class="btn btn-light">Cancel</a>
		</form>
	</div>

<script>
// Disable form submissions if there are invalid fields
(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Get the forms we want to add validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();
</script>
	
</body>

</html>
