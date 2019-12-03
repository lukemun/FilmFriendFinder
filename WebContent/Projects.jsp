<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>


	<%
		Connection conn = null;
		Statement sqlGenres = null;
		Statement sqlDates = null;
		ResultSet resultsGenres = null;
		ResultSet resultsDates = null;
		
		PreparedStatement sqlSearch = null;
		ResultSet resultsSearch = null;
		
		ArrayList<String> titles = new ArrayList<String>();
		int numResults = 0;
		
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
			
			
			sqlSearch = conn.prepareStatement("SELECT DISTINCT Project.projectID, Project.title, Project.created, Genre.genre, Project.summary " 
											+ "FROM Project " 
											+ "JOIN ProjectToGenre " 
											+ "ON Project.projectID = ProjectToGenre.projectID "
											+ "JOIN Genre " 
											+ "ON Genre.genreID = ProjectToGenre.genreID "
											+ "WHERE Genre.genreID LIKE ? AND Project.created LIKE ?");
			String id = "%";
			if (request.getParameter("genre") != null && !request.getParameter("genre").isEmpty()) {
				id = request.getParameter("genre");
			}
			String date = "%";
			if (request.getParameter("date") != null && !request.getParameter("date").isEmpty()) {
				date = request.getParameter("date");
			}
			
			sqlSearch.setString(1, id);
			sqlSearch.setString(2, date);
			
			resultsSearch = sqlSearch.executeQuery();
						
			if (resultsSearch != null) {
				resultsSearch.last(); 
				numResults = resultsSearch.getRow();
				resultsSearch.beforeFirst();
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
	<title>Available Film Projects</title>
	
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
			<h3 class="col-12 mt-2 mb-2 text-center">Available Film Projects</h3>
		</div> 
	</div> 
	<div class="container">
		<div class="row justify-content-center">
			<h6 class="col-12 mt-2 mb-4 text-center">Browse available film projects and network with other USC students!</h6>
		</div> 
	</div> 
	
		<div class="container">
		<form action="Projects.jsp" method="GET">
			<div class="form-group row justify-content-center align-items-center">
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
				<div class="col-auto mt-2 text-center">
					<button type="submit" class="btn btn-dark">Go</button>
				</div>
			</div>
		</form>
	</div>

	<div class="container">
		<div class="row mt-4 mb-4">
			<div class="col-12">
				Results: <%= numResults %> project(s)
			</div>
		</div>
	</div>
	
	<%
		while (resultsSearch != null && resultsSearch.next()) {
			String projectID = resultsSearch.getString("Project.projectID");
			String title = resultsSearch.getString("Project.title");
				if (!titles.contains(title)) {
					
				String datePosted = resultsSearch.getString("Project.created");
				ArrayList<String> genres = new ArrayList<String>();
				
				PreparedStatement sqlProjectGenres = null;
				ResultSet resultsProjectGenres = null;
				sqlProjectGenres = conn.prepareStatement("SELECT Genre.genre FROM Genre "
												+ "JOIN ProjectToGenre " 
												+ "ON Genre.genreID = ProjectToGenre.genreID "
												+ "JOIN Project " 
												+ "ON Project.projectID = ProjectToGenre.projectID "
												+ "WHERE Project.projectID = ?");
				sqlProjectGenres.setInt(1, Integer.parseInt(projectID));
				resultsProjectGenres = sqlProjectGenres.executeQuery();
				
				while (resultsProjectGenres.next()) {
					genres.add(resultsProjectGenres.getString("Genre.genre"));
				}
	
				String summary = resultsSearch.getString("Project.summary");
		%>	
		
		<div class="container">
			<div class="row mt-2">
				<div class="col-12">
					<h5>
						<a class="font-weight-bold text-dark" href="Details.jsp?projectID=<%= projectID %>"><%= title %></a>
					</h5>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<strong>Date Posted:</strong> <%= datePosted %>
				</div>
			</div>
			<div class="row">
				<div class="col-auto">
				<strong>Genre Tags:</strong>
				<%
					for (int i = 0; i < genres.size(); i++) {
				%>
					 <%= genres.get(i) %> 
				 <%
				 }
				 %>
				</div>
			</div>
			<div class="row mt-1 mb-5">
				<div class="col-12 font-italic">
					<%= summary %>
				</div>
			</div>
		</div>
				<%
				titles.add(title);
				}
			}
		%>
</body>
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
	
</html>