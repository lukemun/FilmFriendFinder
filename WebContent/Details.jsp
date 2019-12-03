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
		String error = null;
		Boolean owner = false;
		Boolean posAvailable = false;
		
		Connection conn = null;		
		PreparedStatement sqlSearch = null;
		ResultSet resultsSearch = null;
		
		PreparedStatement sqlUserID = null;
		ResultSet resultsUserID = null;
		
		PreparedStatement sqlPositions = null;
		ResultSet resultsPositions = null;
		
		PreparedStatement sqlOwner = null;
		ResultSet resultsOwner = null;
		
		PreparedStatement sqlProjectApplied = null;
		ResultSet resultsProjectApplied = null;
		
		PreparedStatement sqlProjectAccepted = null;
		ResultSet resultsProjectAccepted = null;
		
		ArrayList<String> titles = new ArrayList<String>();
				
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			sqlSearch = conn.prepareStatement("SELECT Project.projectID, Project.title, Project.created, Genre.genre, Project.avgRating, Project.summary " 
											+ "FROM Project " 
											+ "JOIN ProjectToGenre " 
											+ "ON Project.projectID = ProjectToGenre.projectID "
											+ "JOIN Genre " 
											+ "ON Genre.genreID = ProjectToGenre.genreID "
											+ "WHERE Project.projectID = ?");
			int id = 0;
			
			if (request.getParameter("projectID") != null && !request.getParameter("projectID").isEmpty()) {
				id = Integer.parseInt(request.getParameter("projectID"));
				
				sqlSearch.setInt(1, id);
				resultsSearch = sqlSearch.executeQuery();
				
				// Show available positions
			 	sqlPositions = conn.prepareStatement("SELECT * FROM Position "
			 										+ "JOIN ProjectToPosition "
			 										+ "ON Position.positionID = ProjectToPosition.positionID "
			 										+ "JOIN Project "
			 										+ "ON ProjectToPosition.projectID = Project.projectID " 
			 										+ "WHERE Project.projectID = ?");
			 	sqlPositions.setInt(1, id);

		 		resultsPositions = sqlPositions.executeQuery();
				
				if (request.getSession().getAttribute("activeUser") != null) {
					
					// Show admin section if logged in user is project owner
					sqlUserID = conn.prepareStatement("SELECT userID FROM User WHERE email = ?");
					sqlUserID.setString(1, (String) request.getSession().getAttribute("activeUser"));
					
					resultsUserID = sqlUserID.executeQuery();
								
					if (resultsUserID.next()) {
						int userID = resultsUserID.getInt("userID");
						sqlOwner = conn.prepareStatement("SELECT projectID FROM Project WHERE projectID = ? AND ownerID = ?");
						sqlOwner.setInt(1, id);
						sqlOwner.setInt(2, resultsUserID.getInt("userID"));
						
						resultsOwner = sqlOwner.executeQuery();
						if (resultsOwner.next()) {
							owner = true;
							// Show Applications/Members
							sqlProjectApplied = conn.prepareStatement("SELECT ProjectUsers.puID, User.userID, User.firstName, User.lastName, Position.position, ProjectUsers.accepted "
									+ "FROM ProjectUsers " 
									+ "JOIN Project " 
									+ "ON ProjectUsers.projectID = Project.projectID " 
									+ "JOIN User " 
									+ "ON ProjectUsers.userID = User.userID " 
									+ "JOIN Position " 
									+ "ON ProjectUsers.positionID = Position.positionID " 
									+ "WHERE ProjectUsers.projectID = ? AND (ProjectUsers.accepted = ? OR ProjectUsers.accepted IS NULL)");
							sqlProjectApplied.setInt(1, id);
							sqlProjectApplied.setInt(2, 0);
							resultsProjectApplied = sqlProjectApplied.executeQuery();
							
							sqlProjectAccepted = conn.prepareStatement("SELECT ProjectUsers.puID, User.userID, User.firstName, User.lastName, Position.position, ProjectUsers.accepted "
									+ "FROM ProjectUsers " 
									+ "JOIN Project " 
									+ "ON ProjectUsers.projectID = Project.projectID " 
									+ "JOIN User " 
									+ "ON ProjectUsers.userID = User.userID " 
									+ "JOIN Position " 
									+ "ON ProjectUsers.positionID = Position.positionID " 
									+ "WHERE ProjectUsers.projectID = ? AND ProjectUsers.accepted = ?");
							sqlProjectAccepted.setInt(1, id);
							sqlProjectAccepted.setInt(2, 1);
							resultsProjectAccepted = sqlProjectAccepted.executeQuery();
						}
					}
				}

			}
			else {
				error = "Project ID missing";
			}
	%>

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<title>Details</title>
</head>
<body>
	<%@ include file="Navbar.jsp" %>
	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-12 mt-2 mb-2 text-center">Film Details</h3>
		</div> 
	</div> 
	
	<hr>
	<br>
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
  		<div class="row justify-content-around">
			<div class="col-auto">
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
		<%
		titles.add(title);

				}
			}
		%>
		
				<div class="row mt-2 mb-2">
					<div class="col-12">
						<h5 class="">
							<u>Available Positions:</u>
						</h5>
					</div>
				</div>
				<div class="container">
				<form action="ApplicationConfirmation.jsp?projectID=<%=id %>" method="POST">
				<%
				if (resultsPositions != null) {
					posAvailable = true;
					while (resultsPositions != null && resultsPositions.next()) {
						int positionID = resultsPositions.getInt("positionID");
						String position = resultsPositions.getString("position");
				%>

				<div class="row">
					<div class="col-auto mb-4">
						<%= position %>
					</div>
					<div class="col-auto form-check">
					  <input class="form-check-input position-static" type="checkbox" id="blankCheckbox" name="applyTo" value="<%= positionID %>" aria-label="...">
					</div>
				</div>
				<%
					}
				}
				else {
					%>	
					<div class="row">
						<div class="col-auto mb-4">
							None available.
						</div>
					</div>
					<%
						}
				%>
				
			<div class="row mt-2 mb-2">
					<div class="col">
						<%
							if (request.getSession().getAttribute("activeUser") == null && posAvailable) {
						%>	
			  				<div class="text-danger">Please login to apply to a project.</div>
						<%
							}
							else if (!owner && posAvailable){
						%>
			  				<button type="submit" class="btn btn-dark">Apply</button>
						<%
							}
							else if (owner){
						%>
			  				<a href="EditProject.jsp?projectID=<%= id %>"class="btn btn-dark">Edit</a>
						<%
							}
						%>
					</div>
				</div>
				</form>
			</div>
		</div>

		<%
			if (owner) {
		%>	
		<div class="col-4 border border-dark">
				<div class="row border-bottom border-dark mt-2">
					<div class="col-12 text-center font-weight-bold mb-2">
						<h5 class="mb-1">
							Activity Feed
						</h5>
					</div>
				</div>
				<div class="row">
					<div class="col-12 text-center font-weight-bold mt-1 mb-1">
						Applications
					</div>
				</div>
				<%
				while (resultsProjectApplied != null && resultsProjectApplied.next()) {
					int puID = resultsProjectApplied.getInt("ProjectUsers.puID");
					String position = resultsProjectApplied.getString("Position.position");
					int uID = resultsProjectApplied.getInt("User.userID");
					String fname = resultsProjectApplied.getString("User.firstName");
					String lname = resultsProjectApplied.getString("User.lastName");
					String name = fname + " " + lname;

				%>	
				<div class="row">
					<div class="col-12 font-weight-bold mt-1 mb-1">
						<%= position %>
					</div>
				</div>
				<div class="row justify-content-between">
					<div class="col-auto">
						<a class="text-dark profile" href="Profile.jsp?userID=<%= uID %>"><%= name %></a>
					</div>
					<div class="col-auto align-self-end">
						<a href="MemberConfirmation.jsp?action=accept&puID=<%= puID %>"class="btn btn-link p-0"><i class="fas fa-check pl-2 pr-2"></i></a>
						<a href="MemberConfirmation.jsp?action=reject&puID=<%= puID %>"class="btn btn-link p-0"><i class="fas fa-times pl-2 pr-2"></i></a>
					</div>
				</div>
				<%
					}
				%>
				<div class="row border-top border-dark mt-2">
					<div class="col-12 text-center font-weight-bold mt-2 mb-2">
						Accepted Members
					</div>
				</div>
				<%
				while (resultsProjectAccepted != null && resultsProjectAccepted.next()) {
					
					String position = resultsProjectAccepted.getString("Position.position");
					int uID = resultsProjectAccepted.getInt("User.userID");
					String fname = resultsProjectAccepted.getString("User.firstName");
					String lname = resultsProjectAccepted.getString("User.lastName");
					String name = fname + " " + lname;

				%>
				<div class="row">
					<div class="col-12 font-weight-bold mt-1 mb-1">
						<%= position %>
					</div>
				</div>
				<div class="row justify-content-between">
					<div class="col-auto">
						<a class="text-dark profile" href="Profile.jsp?userID=<%= uID %>"><%= name %></a>
					</div>
				</div>
				<%
					}
			}
			%>
		</div>
			
		</div>
	</div>	

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
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	%>
<style>
	
	.fa-check {
    	color: green;
  	}

	.fa-times {
    	color: red;
  	}
  	
	.profile:hover { 
		text-decoration: none; 
	} 

</style>
</html>