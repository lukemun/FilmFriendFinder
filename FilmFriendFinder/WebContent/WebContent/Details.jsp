<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
		<div class="row">
			<div class="col-8">
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
					<div class="col-12 mb-4">
						Director of Photography
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-4">
						Production Designer
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-4">
						Camera Operator
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-4">
						Lead Actor
					</div>
				</div>
		
			<div class="row mt-2 mb-2">
					<div class="col">
						<button type="submit" class="btn btn-dark">Apply for this project</button>
					</div>
				</div>
			</div>
		
		<div class="col-4 border border-dark">
			<div class="container">
				<div class="row border-bottom border-dark mt-2 mb-3">
					<div class="col-12 text-center mb-2">
						<h5 class="mb-2">
							Activity Feed
						</h5>
						See who else has applied!
					</div>
				</div>
				<div class="row">
					<div class="col-12 mb-2">
						<u>Director of Photography</u>
						<ul>
						  <li>Gordon Willis</li>
						  <li>Stephen Spielberg</li>
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
						  <li>Brad Pitt</li>
						  <li>Bruce Willis</li>
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
	
	.pagination > .active > a
	{
	    color: white;
	    background-color: black !Important;
	    border: solid 1px black !Important;
	}
	
	.pagination > .active > a:hover
	{
	    background-color: grey !Important;
	    border: solid 1px grey;
	}

</style>
</html>
