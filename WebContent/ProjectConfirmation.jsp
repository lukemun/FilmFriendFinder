<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

	<%
	String error = null;
	String result = null;
	if (request.getSession().getAttribute("activeUser") == null) {
		error = "You are not logged in.";
		}
	else if ( request.getParameter("title") == null || request.getParameter("title").isEmpty()
		|| request.getParameter("summary") == null || request.getParameter("summary").isEmpty()) {
			error = "Please fill out all required fields.";
		}
	else {
		Connection conn = null;
		PreparedStatement sqlUserID = null;
		PreparedStatement sqlCreate = null;
		PreparedStatement sqlProject = null;
		PreparedStatement sqlGenre = null;
		PreparedStatement sqlPosition = null;
		ResultSet resultsUserID = null;
		ResultSet resultsProject = null;
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			sqlUserID = conn.prepareStatement("SELECT userID FROM User WHERE email = ?");
			sqlUserID.setString(1, (String) request.getSession().getAttribute("activeUser"));
			
			resultsUserID = sqlUserID.executeQuery();
						
			if (resultsUserID.next()) {
				int userID = resultsUserID.getInt("userID");
				String pattern = "yyyy-MM-dd";
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

				String date = simpleDateFormat.format(new Date());
				
				sqlCreate = conn.prepareStatement("INSERT INTO Project (ownerID, title, summary, numRatings, sumRatings, avgRating, created) " 
						+ "VALUES (?, ?, ?, ?, ?, ?, ?)");
				
				sqlCreate.setInt(1, userID);
				sqlCreate.setString(2, request.getParameter("title"));
				sqlCreate.setString(3, request.getParameter("summary"));
				sqlCreate.setInt(4, 0);
				sqlCreate.setInt(5, 0);
				sqlCreate.setInt(6, 0);
				sqlCreate.setString(7, date);
				
				int row = sqlCreate.executeUpdate();
				
				if (row > 0) {
					sqlProject = conn.prepareStatement("SELECT projectID FROM Project WHERE title = ?");
					sqlProject.setString(1, (request.getParameter("title")));
					
					resultsProject = sqlProject.executeQuery();
					
					if (resultsProject.next()) {
						sqlGenre = conn.prepareStatement("INSERT INTO ProjectToGenre (projectID, genreID) " 
								+ "VALUES (?, ?)");
						sqlGenre.setInt(1, resultsProject.getInt("projectID"));
						sqlGenre.setInt(2, Integer.parseInt(request.getParameter("genre")));
						// should check row value to see if inserted correctly
						row = sqlGenre.executeUpdate();
						
						sqlPosition = conn.prepareStatement("INSERT INTO ProjectToPosition (projectID, positionID) "
								+ "VALUES (?, ?)");
						sqlPosition.setInt(1, resultsProject.getInt("projectID"));
						sqlPosition.setInt(2, Integer.parseInt(request.getParameter("position")));
						row = sqlPosition.executeUpdate();
						
						result = request.getParameter("title") + " created successfully.";
					}
				} 
				else {
					error = "Creation unsuccessful. Please try again.";
				}
			} else {
				error = "Error. Please try logging in and out.";
			}
		} catch (SQLException sqle) {
			System.out.println("SQLE ERROR" + sqle.getMessage());
			sqle.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			System.out.println("CNFE ERROR" + cnfe.getMessage());
			cnfe.printStackTrace();
		} finally {
			try {
 				if (resultsUserID != null) {
 					resultsUserID.close();
				}
				if (sqlCreate != null) {
					sqlCreate.close();
				}
				if (sqlUserID != null) {
					sqlUserID.close();
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
			<h1 class="col-12 mt-4">Project Creation</h1>
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
  			<a href="${header.referer}" role="button" class="btn btn-light">Back</a>
		</div> <!-- .col -->
	</div> <!-- .row -->

</div> <!-- .container -->

</body>
</html>