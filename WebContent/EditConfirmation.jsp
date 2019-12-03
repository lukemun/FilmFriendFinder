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
	String result = "Successfully updated positions";
	int id = 0;
	
	if (request.getSession().getAttribute("activeUser") == null) {
		error = "You are not logged in.";
		}
	else {
		Connection conn = null;
		PreparedStatement sqlDeleteRoles = null;
		ResultSet resultsDeleteRoles = null;
		ResultSet resultsAddRoles = null;
		
		int row = 0;
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			sqlDeleteRoles = conn.prepareStatement("DELETE FROM ProjectToPosition WHERE projectID = ?");
			id = Integer.parseInt(request.getParameter("projectID"));
			sqlDeleteRoles.setInt(1, id);
			row = sqlDeleteRoles.executeUpdate();
			
			String available[] = request.getParameterValues("addPosition");
			for (int i = 0; i < available.length; i++) {
				PreparedStatement sqlAddRoles = conn.prepareStatement("INSERT INTO ProjectToPosition (projectID, positionID) "
						+ "VALUES (?, ?)");
				sqlAddRoles.setInt(1, id);
				sqlAddRoles.setInt(2, Integer.parseInt(available[i]));
				row = sqlAddRoles.executeUpdate();
				
				if (row == 0) {
					error += "Unable to add position " + (available[i]) + ".\n";
				}
				
				System.out.println(available[i]);
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
  			<a href="Details.jsp?projectID=<%= id %>" role="button" class="btn btn-light">Back</a>
		</div> <!-- .col -->
	</div> <!-- .row -->

</div> <!-- .container -->

</body>
</html>