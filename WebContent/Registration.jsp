<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
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
			sql = "SELECT * FROM Position;";
			resultsPositions = sqlPositions.executeQuery(sql);
						
			if (!resultsGenres.isBeforeFirst() ) {    
			    System.out.println("No positions"); 
			} 
	%>
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
	
	<title>Registration</title>
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
			<h1 class="col-12 mt-4 mb-4">Register</h1>
		</div>
	</div>
	<div class="container">
		<form action="RegisterConfirmation.jsp" method="POST" class="needs-validation" novalidate>
			<div class="form-group">
	    		<input type="text" class="form-control" id="fname" placeholder="First Name" name="fname" required>
	    		<div class="valid-feedback"></div>
	    		<div class="invalid-feedback">Please enter your first name.</div>
	  		</div>
	  		<div class="form-group">
	    		<input type="text" class="form-control" id="lname" placeholder="Last Name" name="lname" required>
	    		<div class="valid-feedback"></div>
	    		<div class="invalid-feedback">Please enter your last name.</div>
	  		</div>
	  		<div class="form-group">
	    		<input type="email" class="form-control" id="email" placeholder="USC Email" name="email" required>
	    		<div class="valid-feedback"></div>
	    		<div class="invalid-feedback">Please enter your USC email.</div>
	  		</div>
	  		<div class="form-group">
	    		<input type="password" class="form-control" id="pwd" placeholder="Password" name="pwd" required>
	    		<div class="valid-feedback"></div>
	    		<div class="invalid-feedback">Please enter password.</div>
	  		</div>
	  		<div class="form-group">
	    		<input type="password" class="form-control" id="cpwd" placeholder="Confirm Password" name="cpwd" required>
	    		<div class="valid-feedback"></div>
	    		<div class="invalid-feedback">Please confirm your password.</div>
	  		</div>
	  		<div class="form-group">
  				<label for="genre">Genre(s) You're interested in</label>
				<select name="genre" id="genre-id" class="form-control selectpicker" multiple>
					<option value="" disabled>--Genre--</option>
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
	  		<div class="form-group">
  				<label for="position">Positions(s) You're interested in</label>
				<select name="position" id="position-id" class="form-control selectpicker" multiple>
					<option value="" disabled>--Position--</option>
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
				</div>
<!-- 	  		 <div class="custom-file">
    			<input type="file" class="custom-file-input" id="customFile" required>
    			<label class="custom-file-label" for="customFile">Upload Resume</label>
		        <div class = "invalid-feedback">Please upload your resume.</div>
  			</div> -->
	  		<br></br><button type="submit" class="btn btn-dark">Submit</button>
	  		<a href="${header.referer}" role="button" class="btn btn-light">Cancel</a>
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
        else if($('#pwd').val() != $('#cpwd').val()) {
        	event.preventDefault();
            event.stopPropagation();	
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();
//Changes color of confirm password field
$('#pwd, #cpwd').on('keyup', function () {
	  if ($('#pwd').val() == $('#cpwd').val() && $('#pwd').val().length > 1) {
	    $('#cpwd').css('background-color', 'white');
	  } else 
	    $('#cpwd').css('background-color', '#ff7f7f');
	});
</script>
	
</body>
</html>