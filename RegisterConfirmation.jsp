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

	if ( request.getParameter("fname") == null 
		|| request.getParameter("fname").isEmpty()
		|| request.getParameter("lname") == null 
		|| request.getParameter("lname").isEmpty()
		|| request.getParameter("email") == null 
		|| request.getParameter("email").isEmpty() 
		|| request.getParameter("pwd") == null 
		|| request.getParameter("pwd").isEmpty()
		|| request.getParameter("cpwd") == null 
		|| request.getParameter("cpwd").isEmpty()) {
			error = "Please fill out all required fields.";
		}
	else {
		Connection conn = null;
		PreparedStatement sqlUserExists = null;
		PreparedStatement sqlRegister = null;
		PreparedStatement sqlNewUserID = null;
		ResultSet resultsUserExists = null;
		ResultSet resultsNewUserID = null;
		
		PreparedStatement sqlGenre = null;
		PreparedStatement sqlPosition = null;
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			sqlUserExists = conn.prepareStatement("SELECT email FROM User WHERE email = ?");
			sqlUserExists.setString(1, request.getParameter("email"));

			resultsUserExists = sqlUserExists.executeQuery();
						
			if (resultsUserExists.next()) {
				error = "Email already exists";
			} else {
				sqlRegister = conn.prepareStatement("INSERT INTO User (firstName, lastName, email, password) " 
													+ "VALUES (?, ?, ?, ?)");
				sqlRegister.setString(1, request.getParameter("fname"));
				sqlRegister.setString(2, request.getParameter("lname"));
				sqlRegister.setString(3, request.getParameter("email"));
				sqlRegister.setString(4, request.getParameter("pwd"));
				
				int row = sqlRegister.executeUpdate();
				
				if (row > 0) {
					sqlNewUserID = conn.prepareStatement("SELECT userID FROM User WHERE email = ?");
					sqlNewUserID.setString(1, request.getParameter("email"));
					
					resultsNewUserID = sqlNewUserID.executeQuery();
					if (resultsNewUserID.next()) {
						// Need to add genres/positions
						
						sqlGenre = conn.prepareStatement("INSERT INTO UserToGenre (userID, genreID) " 
								+ "VALUES (?, ?)");
						sqlGenre.setInt(1, resultsNewUserID.getInt("userID"));
						sqlGenre.setInt(2, Integer.parseInt(request.getParameter("genre")));
						row = sqlGenre.executeUpdate();
						
						sqlPosition = conn.prepareStatement("INSERT INTO UserToPosition (userID, positionID) "
								+ "VALUES (?, ?)");
						sqlPosition.setInt(1, resultsNewUserID.getInt("userID"));
						sqlPosition.setInt(2, Integer.parseInt(request.getParameter("position")));
						row = sqlPosition.executeUpdate();
						
						result = "Accounted created and logged in!";
						request.getSession().setAttribute("loggedIn", true);
						request.getSession().setAttribute("activeUser", request.getParameter("email"));
					}
				}
				else {
					error = "Registration unsuccessful. Please try again.";
				}
			}
		} catch (SQLException sqle) {
			System.out.println("SQLE ERROR" + sqle.getMessage());
			sqle.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			System.out.println("CNFE ERROR" + cnfe.getMessage());
			cnfe.printStackTrace();
		} finally {
			try {
 				if (resultsNewUserID != null) {
 					resultsNewUserID.close();
				}
 				if (resultsUserExists != null) {
 					resultsUserExists.close();
				}
				if (sqlNewUserID != null) {
					sqlNewUserID.close();
				}
				if (sqlRegister != null) {
					sqlRegister.close();
				}
				if (sqlUserExists != null) {
					sqlUserExists.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
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
	<title>Registration</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
	
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4">User Registration</h1>
		</div> <!-- .row -->
	</div> <!-- .container -->

	<div class="container">

		<div class="row mt-4">
			<div class="col-12">
				<%
					if (error != null) {
				%>					
				<div class="text-danger"><%= error %></div>
				<%
					}
					else if (result != null){
				%>
					<div class="text-success"><%= result %></div>
				<%
					}
				%>
		</div> <!-- .col -->
	</div> <!-- .row -->

	<div class="row mt-4 mb-4">
		<div class="col-12">
  			<a href="HomePage.jsp" role="button" class="btn btn-light">Home</a>
		</div> <!-- .col -->
	</div> <!-- .row -->

</div> <!-- .container -->
	
</body>
</html>