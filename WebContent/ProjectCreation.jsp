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
		Statement sqlPositions = null;
		ResultSet resultsGenres = null;
		ResultSet resultsPositions = null;
		
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
			
			sqlPositions = conn.createStatement();
			sql = "SELECT * FROM Position ORDER BY position;";
			resultsPositions = sqlPositions.executeQuery(sql);
						
			if (!resultsPositions.isBeforeFirst() ) {    
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
	
	 <!-- Multiple selections for the genre tag -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
	
	<title>Project Creation</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4 mb-4">Post a Project</h1>
		</div>
	</div>
	<div class="container">
		<form action="ProjectConfirmation.jsp" method="POST" class="needs-validation" novalidate>
			<div class="form-group">
    			<label for="title">Project Title</label>
    			<input type="text" class="form-control" id="title" placeholder="Project Title" name="title" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter a project title.</div>
  			</div>
  			<div class="form-group">
    			<label for="summary">Project Summary</label>
    			<input type="text" class="form-control" id="summary" placeholder="Project Summary" name="summary" size = "35" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter the project summary.</div>
  			</div>
  			<div class="form-group">
  				<label for="genre">Genre Tags</label>
 					<select name="genre" id="genre" class="form-control selectpicker" multiple required>
						<option value="" disabled selected>--Genre--</option>
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
				<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please select genre.</div>
  			</div>
  			<div class="form-group">
    			<label for="position">Position(s) You're Looking For</label>
    			 	<select name="position" id="postion" class="form-control selectpicker" multiple required>
						<option value="" disabled selected>--Positions--</option>
						<%
						while (resultsPositions != null && resultsPositions.next()) {
							int positionID = resultsPositions.getInt("positionID");
							String position = resultsPositions.getString("position");
						%>	
						<option value="<%= positionID %>"><%= position %></option>
						<%
							}
						%>
					</select>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter the position(s) you're looking for.</div>
  			</div>
  			<%
				if (request.getSession().getAttribute("activeUser") == null) {
			%>
  			<div class="form-group">
    			<div class="text-danger">Please login to post a project.</div>
  			</div>
			<%
			}
			else {
			%>
  			<button type="submit" class="btn btn-dark">Post</button>
			<%
				}
			%>
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

<script>
// Disable form submissions if there are invalid fields
(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Get the forms we want to add validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();
</script>
	
</body>

</html>