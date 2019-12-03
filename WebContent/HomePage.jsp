<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

	<%
		Connection conn = null;
		Statement sqlGenres = null;
		Statement sqlDates = null;
		ResultSet resultsGenres = null;
		ResultSet resultsDates = null;
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			sqlGenres = conn.createStatement();
			String sql = "SELECT * FROM Genre;";
			resultsGenres = sqlGenres.executeQuery(sql);
						
			if (!resultsGenres.isBeforeFirst() ) {    
			    System.out.println("No genres"); 
			} 
			
			sqlDates = conn.createStatement();
			sql = "SELECT DISTINCT created FROM Project ORDER BY created DESC;";
			resultsDates = sqlDates.executeQuery(sql);
						
			if (!resultsGenres.isBeforeFirst() ) {    
			    System.out.println("No dates"); 
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
		<div class="row justify-content-center">
			<h1 class="col-12 mt-2 mb-2 text-center">Film Friend Finder</h1>
		</div> 
	</div> 
	<div class="container">
		<div class="row justify-content-center">
			<h4 class="col-12 mt-2 mb-4 text-center font-italic">The Destination To Find Your Film Group Members</h4>
		</div> 
	</div> 
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-8 mt-1 mb-1 text-center">
				<img src="images/projector.jpg" class="img-fluid" alt="projector"/>
			</div>
		</div> 
	</div> 
	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-8 mt-4 mb-2 text-center">How It Works:</h3>
		</div> 
		<div class="row justify-content-center">
			<div class="col-8 mt-0 mb-3 text-justify">
				Search for available film projects to join by filtering on genre, date posted, 
				and/or popularity of the film.
				If you have your own project and want to find members to fill open positions, 
				create an account to post details of your film project and network with other USC students!
			</div>
		</div> 
	</div> 
	
	<hr/>
	
	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-8 mt-2 mb-3 text-center">Get Started Now!</h3>
		</div>
	</div> 
	
	<div class="container">
		<form action="Projects.jsp" method="GET">
			<div class="form-group row justify-content-center align-items-center">
				<div class="col-auto mt-1">Search:</div>
				<label for="genre-id" class="d-none"></label>
				<div class="col-auto mt-1">
					<select name="genre" id="genre-id" class="form-control">
						<option value="" selected>--Genre--</option>
						<%
						while (resultsGenres != null && resultsGenres.next()) {
							int genreID = resultsGenres.getInt("genreID");
							String genre = resultsGenres.getString("genre");
						%>	
						<option value="<%= genreID %>"><%= genre %></option>
						<%
							}
						%>
					</select>				
				</div>
				<label for="date-id" class="d-none"></label>
				<div class="col-auto mt-1">
					<select name="date" id="date-id" class="form-control">
						<option value="" selected>--Date Posted--</option>
						<%
						while (resultsDates != null && resultsDates.next()) {
							String created = resultsDates.getString("created");
						%>	
						<option value="<%= created %>"><%= created %></option>
						<%
							}
						%>
					</select>
				</div>
			</div>
			<div class="form-group row justify-content-center">
				<div class="col-sm-9 mt-2 text-center">
					<button type="submit" class="btn btn-dark">View Available Film Projects</button>
				</div>
			</div>
		</form>
	</div>
	<%
		} catch (SQLException sqle) {
			System.out.println("SQLE ERROR" + sqle.getMessage());
			sqle.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			System.out.println("CNFE ERROR" + cnfe.getMessage());
			cnfe.printStackTrace();
		} finally {
			try {
 				if (resultsGenres != null) {
					resultsGenres.close();
				}
				if (sqlGenres != null) {
					sqlGenres.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		%>

</body>
</html>