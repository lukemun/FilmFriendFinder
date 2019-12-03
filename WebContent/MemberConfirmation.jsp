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
	else if ( request.getParameter("puID") == null || request.getParameter("puID").isEmpty()) {
			error = "Please select a user to accept/reject";
		}
	else {
		Connection conn = null;
		PreparedStatement sqlUpdateStatus = null;
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			String action = request.getParameter("action");
			int status = 0;
			
			if (action.compareTo("accept") == 0) {
				status = 1;
			}
			
			sqlUpdateStatus = conn.prepareStatement("UPDATE ProjectUsers SET accepted = ? WHERE puID = ?");
			sqlUpdateStatus.setInt(1, status);
			sqlUpdateStatus.setInt(2, Integer.parseInt(request.getParameter("puID")));
			
			int row = sqlUpdateStatus.executeUpdate();
			
			if (row > 0) {
				// get name?
				if (status == 0) {
					result = "Member successfully rejected.";
				}
				else {
					result = "Member successfully accepted.";
				}
			} 
			else {
				error = "Unable to update application. Please try again.";
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
	<title>Member Confirmation</title>
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