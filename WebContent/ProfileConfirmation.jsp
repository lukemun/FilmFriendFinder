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
		PreparedStatement sqlDeletePosition = null;
		PreparedStatement sqlDeleteGenres = null;
		ResultSet resultsDeletePositions = null;
		ResultSet resultsDeleteGenres = null;
		
		int row = 0;
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			String type = "";
			
			if (request.getParameter("type") != null) {
				type = request.getParameter("type");
			}
			
			if (type.compareTo("position") == 0) {
				sqlDeletePosition = conn.prepareStatement("DELETE FROM UserToPosition WHERE userID = ?");
				id = (Integer) request.getSession().getAttribute("activeUserID");
				sqlDeletePosition.setInt(1, id);
				
				row = sqlDeletePosition.executeUpdate();
				
				String positions[] = request.getParameterValues("addPosition");
				for (int i = 0; i < positions.length; i++) {
					PreparedStatement sqlAddRoles = conn.prepareStatement("INSERT INTO UserToPosition (userID, positionID) "
							+ "VALUES (?, ?)");
					sqlAddRoles.setInt(1, id);
					sqlAddRoles.setInt(2, Integer.parseInt(positions[i]));
					row = sqlAddRoles.executeUpdate();
					
					if (row == 0) {
						error += "Unable to add position " + (positions[i]) + ".\n";
					}	
				}
			}
			
			else if (type.compareTo("genre") == 0) {
				sqlDeleteGenres = conn.prepareStatement("DELETE FROM UserToGenre WHERE userID = ?");
				id = (Integer) request.getSession().getAttribute("activeUserID");
				sqlDeleteGenres.setInt(1, id);
				
				row = sqlDeleteGenres.executeUpdate();
				
				String genres[] = request.getParameterValues("addGenre");
				for (int i = 0; i < genres.length; i++) {
					PreparedStatement sqlAddRoles = conn.prepareStatement("INSERT INTO UserToGenre (userID, genreID) "
							+ "VALUES (?, ?)");
					sqlAddRoles.setInt(1, id);
					sqlAddRoles.setInt(2, Integer.parseInt(genres[i]));
					row = sqlAddRoles.executeUpdate();
					
					if (row == 0) {
						error += "Unable to add position " + (genres[i]) + ".\n";
					}	
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
	<title>Profile Edit</title>
    <script>

        function checkForNewProject()
        {
            var source = new EventSource('http://localhost:8080/FilmFriendFinder/SendNotification');  
            source.onmessage=function(event) {
                document.getElementById("result").innerHTML=event.data + "<br />";
                $("#result").show(); 
                $("#result").hide().slideDown().delay(10000).fadeOut();
            };
        }
    </script>
</head>

<body onload="checkForNewProject()">
	<%@ include file="Navbar.jsp" %>
	<div class="container-fluid">
		<div class="row justify-content-end">
			<div class="col-auto mt-2-mb-2">
				<output id ="result" class="font-weight-bold text-success mt-3 mb-3"> </output>
			</div>
		</div> 
	</div> 
	
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4">Preferences Edit</h1>
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
  			<a href="Profile.jsp" role="button" class="btn btn-light">Back</a>
		</div> <!-- .col -->
	</div> <!-- .row -->

</div> <!-- .container -->

</body>
</html>