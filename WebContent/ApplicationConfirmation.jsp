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
	else if ( request.getParameter("applyTo") == null || request.getParameter("applyTo").isEmpty()) {
			error = "Please select a position to apply to.";
		}
	else {
		Connection conn = null;
		PreparedStatement sqlApply = null;
		PreparedStatement sqlAlreadyApplied = null;
		ResultSet resultsAlreadyApplied = null;

		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			sqlAlreadyApplied = conn.prepareStatement("SELECT puID FROM ProjectUsers WHERE userID = ? AND projectID = ? AND positionID = ?");
			sqlAlreadyApplied.setInt(1, (Integer) request.getSession().getAttribute("activeUserID"));
			sqlAlreadyApplied.setInt(2, Integer.parseInt(request.getParameter("projectID")));
			sqlAlreadyApplied.setInt(3, Integer.parseInt(request.getParameter("applyTo")));
			
			resultsAlreadyApplied = sqlAlreadyApplied.executeQuery();
			
			if (resultsAlreadyApplied.next()) {
				error = "You have already applied for this position.";
			} 
			else {
				sqlApply = conn.prepareStatement("INSERT INTO ProjectUsers (userID, projectID, positionID) " 
						+ "VALUES (?, ?, ?)");
				sqlApply.setInt(1, (Integer) request.getSession().getAttribute("activeUserID"));
				sqlApply.setInt(2, Integer.parseInt(request.getParameter("projectID")));
				sqlApply.setInt(3, Integer.parseInt(request.getParameter("applyTo")));
				
				int row = sqlApply.executeUpdate();
							
				if (row > 0) {
					result = "Application successful!";
					} 
				else {
					error = "Application unsuccessful. Please try again.";
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
	<title>Application Confirmation</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
	
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4">Application Confirmation</h1>
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