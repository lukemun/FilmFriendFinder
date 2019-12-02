<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<!-- TODO: Update with dynamic results -->
	<div class="container">
  		<div class="row justify-content-around">
			<div class="col-7">
				<div class="row mt-2">
					<div class="col-12">
						<h5>
							<a class="font-weight-bold text-dark" href="">The Godfather</a>
						</h5>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<strong>Date Posted:</strong> November 9, 2019
					</div>
				</div>
				<div class="row">
					<div class="col-auto">
						<strong>Genre Tags:</strong> Crime, Drama	
					</div>
					<div class="col-auto">
						<strong>Rating:</strong> <span class="stars-container stars-80">★★★★★</span>
						<div id="stars-value">80</div>
					</div>
				</div>
				<div class="row mt-1 mb-5">
					<div class="col-12 font-italic">
						The aging patriarch of an organized crime dynasty transfers control of his 
						clandestine empire to his reluctant son.
					</div>
				</div>
		
				<div class="row mt-2 mb-2">
					<div class="col-12">
						<h5 class="">
							<u>Available Positions:</u>
						</h5>
					</div>
				</div>
				<div class="row">
					<div class="col-auto mb-4">
						Director of Photography
					</div>
					<div class="col-auto form-check">
					  <input class="form-check-input position-static" type="checkbox" id="blankCheckbox" value="option1" aria-label="...">
					</div>
				</div>
				<div class="row">
					<div class="col-auto mb-4">
						Production Designer
					</div>
					<div class="col-auto form-check">
					  <input class="form-check-input position-static" type="checkbox" id="blankCheckbox" value="option1" aria-label="...">
					</div>
				</div>
				<div class="row">
					<div class="col-auto mb-4">
						Camera Operator
					</div>
					<div class="col-auto form-check">
					  <input class="form-check-input position-static" type="checkbox" id="blankCheckbox" value="option1" aria-label="...">
					</div>
				</div>
				<div class="row">
					<div class="col-auto mb-4">
						Lead Actor
					</div>
					<div class="col-auto form-check">
					  <input class="form-check-input position-static" type="checkbox" id="blankCheckbox" value="option1" aria-label="...">
					</div>
				</div>
		
			<!-- TODO: Only show if logged in and spots available -->
			<div class="row mt-2 mb-2">
					<div class="col">
						<button type="submit" class="btn btn-dark">Apply for this project</button>
					</div>
				</div>
			</div>
		
		<!-- TODO: Only show if project owner? -->
		<!-- Add approve/reject buttons -->
		<!-- Add links to users profile -->
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
				<div class="row">
					<div class="col-12 font-weight-bold mt-1 mb-1">
						Director of Photography
					</div>
				</div>
				<div class="row justify-content-between">
					<div class="col-auto">
						<a class="text-dark profile" href="Profile.jsp">Stephen Spielberg</a>
					</div>
					<div class="col-auto align-self-end">
						<button type="button" class="btn btn-link p-0">
							<i class="fas fa-check pl-2 pr-2"></i>
						</button>
						<button type="button" class="btn btn-link p-0">
							<i class="fas fa-times pl-2 pr-2"></i>
						</button>
					</div>
				</div>
				<div class="row">
					<div class="col-12 font-weight-bold mt-1 mb-1">
						Production Designer
					</div>
				</div>
				<div class="row">
					<div class="col-auto">
						None
					</div>
				</div>
				<div class="row">
					<div class="col-12 mt-1 mb-1">
						<u>Camera Operator</u>
					</div>
				</div>
				<div class="row">
					<div class="col-auto">
						None
					</div>
				</div>
				<div class="row">
					<div class="col-12 mt-1 mb-1">
						<u>Lead Actor</u>
					</div>
				</div>
				<div class="row justify-content-between">
					<div class="col-auto">
						Brad Pitt
					</div>
					<div class="col-auto align-self-end">
						<button type="button" class="btn btn-link p-0">
							<i class="fas fa-check pl-2 pr-2"></i>
						</button>
						<button type="button" class="btn btn-link p-0">
							<i class="fas fa-times pl-2 pr-2"></i>
						</button>
					</div>
				</div>
				<div class="row justify-content-between">
					<div class="col-auto">
						Bruce Willis
					</div>
					<div class="col-auto align-self-end">
						<button type="button" class="btn btn-link p-0">
							<i class="fas fa-check pl-2 pr-2"></i>
						</button>
						<button type="button" class="btn btn-link p-0">
							<i class="fas fa-times pl-2 pr-2"></i>
						</button>
					</div>
				</div>
				<div class="row border-top border-dark mt-2">
					<div class="col-12 text-center mt-2 mb-2">
						Members
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-2">
						<u>Director of Photography</u>
						<ul>
						  <li>Gordon Willis</li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-2">
						<u>Production Designer</u>
						<ul>
							N/A
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-2">
						<u>Camera Operator</u>
						<ul>
						  <li>Michael Chapman</li>
						  <li>Drew Stanley</li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-2">
						<u>Lead Actor</u>
						<ul>
						  <li>Marlon Brando</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
			
		</div>
	</div>	

</body>

<style>

	.stars-container {
	  position: relative;
	  display: inline-block;
	  color: transparent;
	}
	
	.stars-container:before {
	  position: absolute;
	  top: 0;
	  left: 0;
	  content: '★★★★★';
	  color: lightgray;
	}
	
	.stars-container:after {
	  position: absolute;
	  top: 0;
	  left: 0;
	  content: '★★★★★';
	  color: black;
	  overflow: hidden;
	}
	
	.stars-0:after { width: 0%; }
	.stars-10:after { width: 10%; }
	.stars-20:after { width: 20%; }
	.stars-30:after { width: 30%; }
	.stars-40:after { width: 40%; }
	.stars-50:after { width: 50%; }
	.stars-60:after { width: 60%; }
	.stars-70:after { width: 70%; }
	.stars-80:after { width: 80%; }
	.stars-90:after { width: 90%; }
	.stars-100:after { width: 100; }
	
	#stars-value {
		display: none;
	}
	
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