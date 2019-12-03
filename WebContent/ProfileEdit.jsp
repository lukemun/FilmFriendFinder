<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>

<%
		Connection conn = null;
		PreparedStatement sqlUserExists = null;
		PreparedStatement sqlGenres = null;
		PreparedStatement sqlPositions = null;
		ResultSet resultsUserExists = null;
		ResultSet resultsGenres = null;
		ResultSet resultsPositions = null;
		
		Statement sqlAllPositions = null;
		ResultSet resultsAllPositions = null;
		
		Statement sqlAllGenres = null;
		ResultSet resultsAllGenres = null;
		
		PreparedStatement sqlInProgress = null;
		PreparedStatement sqlAppliedTo = null;
		ResultSet resultsInProgress = null;
		ResultSet resultsAppliedTo = null;
		
		String name = null;
		Boolean self = false;
		Boolean hasInProgress = true;
		Boolean hasAppliedTo = true;
		
		int userID = 0;
		
		if ( request.getParameter("userID") == null || (Integer) request.getSession().getAttribute("activeUserID") == Integer.parseInt(request.getParameter("userID"))) {
			self = true;
			userID = (Integer) request.getSession().getAttribute("activeUserID");
		}
		
		try  {
			Class.forName("com.mysql.jdbc.Driver");  
			conn = DriverManager.getConnection("jdbc:mysql://google/fff"
					+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=root"
					+ "&password=root");
			
			if (!self) {
				userID = Integer.parseInt(request.getParameter("userID"));
				sqlUserExists = conn.prepareStatement("SELECT firstName, lastName FROM User WHERE userID = ?");
				sqlUserExists.setInt(1, userID);

				resultsUserExists = sqlUserExists.executeQuery();
							
				if (resultsUserExists.next()) {
					name = resultsUserExists.getString("firstName") + " " + resultsUserExists.getString("lastName");
				} 
			}
			
			String type = "";
			
			if (request.getParameter("type") != null) {
				type = request.getParameter("type");
			}
			
			if (type.compareTo("position") == 0) {
				sqlAllPositions = conn.createStatement();
				resultsAllPositions = sqlAllPositions.executeQuery("SELECT * FROM Position;");
			
				if (!resultsAllPositions.isBeforeFirst() ) {    
				    System.out.println("No positions"); 
				}
			}
			
			else if (type.compareTo("genre") == 0) {
				sqlAllGenres = conn.createStatement();
				resultsAllGenres = sqlAllGenres.executeQuery("SELECT * FROM Genre;");
				
				if (!resultsAllGenres.isBeforeFirst() ) {    
				    System.out.println("No genres"); 
				}
			}
			
			if (request.getSession().getAttribute("activeUserID") != null) {  
				sqlGenres = conn.prepareStatement("SELECT Genre.genre "
												+ "FROM Genre "
												+ "JOIN UserToGenre "
												+ "ON Genre.genreID = UserToGenre.genreID "
												+ "WHERE UserToGenre.userID = ?");
				sqlGenres.setInt(1, userID);
				resultsGenres = sqlGenres.executeQuery();
							
				if (!resultsGenres.isBeforeFirst() ) {    
				    System.out.println("No genres"); 
				} 
				
				sqlPositions = conn.prepareStatement("SELECT Position.position "
						+ "FROM Position "
						+ "JOIN UserToPosition "
						+ "ON Position.positionID = UserToPosition.positionID "
						+ "WHERE UserToPosition.userID = ?");
				sqlPositions.setInt(1, userID);
				resultsPositions = sqlPositions.executeQuery();
				
				if (!resultsGenres.isBeforeFirst() ) {    
				System.out.println("No position"); 
				}
				
				sqlInProgress = conn.prepareStatement("SELECT Project.projectID, Project.title, Position.position "
						+ "FROM ProjectUsers "
						+ "JOIN Project "
						+ "ON ProjectUsers.projectID = Project.projectID "
						+ "JOIN Position "
						+ "ON ProjectUsers.positionID = Position.positionID "
						+ "WHERE ProjectUsers.userID = ? AND ProjectUsers.accepted = ?");
				sqlInProgress.setInt(1, userID);
				sqlInProgress.setInt(2, 1);
				resultsInProgress = sqlInProgress.executeQuery();
					
				if (!resultsInProgress.isBeforeFirst() ) {    
					hasInProgress = false;
				} 
				
				sqlAppliedTo = conn.prepareStatement("SELECT Project.projectID, Project.title, Position.position "
						+ "FROM ProjectUsers "
						+ "JOIN Project "
						+ "ON ProjectUsers.projectID = Project.projectID "
						+ "JOIN Position "
						+ "ON ProjectUsers.positionID = Position.positionID "
						+ "WHERE ProjectUsers.userID = ? AND ProjectUsers.accepted IS NULL");
				sqlAppliedTo.setInt(1, userID);
				resultsAppliedTo = sqlAppliedTo.executeQuery();
					
				if (!resultsAppliedTo.isBeforeFirst() ) {    
					hasAppliedTo = false;
				} 
			}
			else {
			    System.out.println("No userID");
			}

			%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<title>Profile</title>
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

	<%
		// Need this attribute to be set by Login servlet 
		if (request.getSession().getAttribute("activeUser") != null) {
			if (self) {
	%>

	<div class="row justify-content-center">
		<h2 class="col-12 mt-2 mb-2 text-center">Your Profile</h2>
	</div>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-6 mt-2 mb-2 text-center">
				<h4>Preferred Genres</h4>
				<%
				if (type.compareTo("genre") == 0) {
				%>
				<form action="ProfileConfirmation.jsp?type=genre" method="POST">
					<%
					if (resultsAllGenres != null) {
						while (resultsAllGenres != null && resultsAllGenres.next()) {
							int genreID = resultsAllGenres.getInt("genreID");
							String genre = resultsAllGenres.getString("genre");
					%>
					<div class="row">
						<div class="col-auto mb-2">
							<%= genre %>
						</div>
						<div class="col-auto form-check">
							<input class="form-check-input position-static" type="checkbox"
								id="blankCheckbox" name="addGenre" value="<%= genreID %>"
								aria-label="...">
						</div>
					</div>
					<%
						}
					}
					else {
						%>
					<div class="row">
						<div class="col-auto mb-4">None available.</div>
					</div>
					<%
							}
					%>

					<div class="row mt-2 mb-2">
						<div class="col">
							<br></br>
							<button type="submit" class="btn btn-dark">Save</button>
							<a href="${header.referer}" role="button" class="btn btn-light">Cancel</a>
						</div>
					</div>
				</form>
				<%
				} 
				else {
					while (resultsGenres != null && resultsGenres.next()) {
						String genre = resultsGenres.getString("Genre.genre");
					%>
				<div class="row justify-content-center">
					<%= genre %>
				</div>
				<%
						}
					%>
				<a href="ProfileEdit.jsp?type=genre" class="btn btn-dark mt-4 mb-2">Edit</a>
				<% 
				}
				%>
				</div>
				<div class="col-6 mt-2 mb-2 text-center">
					<h4>Preferred Positions</h4>
					<%
				if (type.compareTo("position") == 0) {
				%>
					<form action="ProfileConfirmation.jsp?type=position" method="POST">
						<%
					if (resultsAllPositions != null) {
						while (resultsAllPositions != null && resultsAllPositions.next()) {
							int positionID = resultsAllPositions.getInt("positionID");
							String position = resultsAllPositions.getString("position");
					%>
						<div class="row">
							<div class="col-auto mb-2">
								<%= position %>
							</div>
							<div class="col-auto form-check">
								<input class="form-check-input position-static" type="checkbox"
									id="blankCheckbox" name="addPosition" value="<%= positionID %>"
									aria-label="...">
							</div>
						</div>
						<%
						}
					}
					else {
						%>
						<div class="row">
							<div class="col-auto mb-4">None available.</div>
						</div>
						<%
							}
					%>

						<div class="row mt-2 mb-2">
							<div class="col">
								<br></br>
								<button type="submit" class="btn btn-dark">Save</button>
								<a href="${header.referer}" role="button" class="btn btn-light">Cancel</a>
							</div>
						</div>
					</form>
					<%
				} 
				else {
					while (resultsGenres != null && resultsGenres.next()) {
						String genre = resultsGenres.getString("Genre.genre");
					%>
					<div class="row justify-content-center">
						<%= genre %>
					</div>
					<%
						}
					%>
					<a href="ProfileEdit.jsp?type=position" class="btn btn-dark mt-4 mb-2">Edit</a>
					<% 
				}
				%>
				</div>
			</div>
		</div>
	</div>

	<hr>
	<br>

	<%
		}
		else {
	%>
	<div class="row justify-content-center">
		<h2 class="col-12 mt-2 mb-2 text-center"><%=name %>
			Profile
		</h2>
	</div>
	<%
		}
	%>

	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-12 mt-2 mb-2 text-center">In-Progress Projects</h3>
		</div>
		<div class="row justify-content-center">
			<div class="col-auto">
				<%
				if (hasInProgress) {
			%>
				<table class="table table-hover table-responsive mt-4">
					<thead>
						<tr>
							<th>Project Name</th>
							<th>Role</th>
						</tr>
					</thead>
					<tbody>
						<% while (resultsInProgress != null && resultsInProgress.next()) {
							int projectID = resultsInProgress.getInt("projectID");
							String title = resultsInProgress.getString("Project.title");
							String position = resultsInProgress.getString("Position.position");
						%>
						<tr>
							<td><a href="Details.jsp?projectID=<%= projectID %>"><%= title %></a>
							</td>
							<td><%= position %></td>
						</tr>
						<%
								}
								%>
					</tbody>
				</table>
				<%
					}
				else {
					%>
				None
				<%
				}
			%>
			</div>
		</div>
	</div>

	<hr>
	<br>

	<div class="container">
		<div class="row justify-content-center">
			<h3 class="col-12 mt-2 mb-2 text-center">Projects Applied To</h3>
		</div>
		<div class="row justify-content-center">
			<div class="col-auto">
				<%
				if (hasAppliedTo) {
			%>
				<table class="table table-hover table-responsive mt-4">
					<thead>
						<tr>
							<th>Project Name</th>
							<th>Role</th>
							<% if (self) {
								%>
							<th></th>
							<%
								}
								%>
						</tr>
					</thead>
					<tbody>
						<% while (resultsAppliedTo != null && resultsAppliedTo.next()) {
							int projectID = resultsAppliedTo.getInt("projectID");
							String title = resultsAppliedTo.getString("Project.title");
							String position = resultsAppliedTo.getString("Position.position");
						%>
						<tr>
							<td><a href="Details.jsp?projectID=<%= projectID %>"><%= title %></a>
							</td>
							<td><%= position %></td>
							<% if (self) {
								%>
							<td><!-- <a href="" class="btn btn-outline-danger"
								onclick="return confirm('Are you sure you want to withdraw your application?');">
									Cancel </a> --></td>
							<%
									}
								%>
						</tr>
						<%
								}
								%>
					</tbody>
				</table>
				<%
					}
				else {
					%>
				None
				<%
				}
			%>
			</div>
		</div>
	</div>

	<%
	}
	else {
	%>
	<div class="row justify-content-center">
		<h2 class="col-12 mt-2 mb-2 text-center">You are not logged in</h2>
	</div>
	<%
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