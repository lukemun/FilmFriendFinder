<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<title>Film Friend Finder</title>
</head>
<body>
	<%@ include file="Navbar.jsp" %>
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
		<!-- TODO: Set search servlet -->
		<form action="" method="GET">
			<div class="form-group row justify-content-center align-items-center">
				<div class="col-sm-2 mt-1">Search:</div>
				<label for="genre-id" class="d-none"></label>
				<div class="col-sm-3 mt-1">
					<select name="genre" id="genre-id" class="form-control">
						<option value="" selected>Genre</option>
						<!-- TODO: Fill search options -->
						<option value=""></option>
					</select>				
				</div>
				<label for="date-id" class="d-none"></label>
				<div class="col-sm-3 mt-1">
					<select name="date" id="date-id" class="form-control">
						<option value="" selected>Date Posted</option>
						<!-- TODO: Fill search options -->
						<option value=""></option>
					</select>
				</div>
				<label for="popularity-id" class="d-none"></label>
				<div class="col-sm-3 mt-1">
					<select name="popularity" id="popularity-id" class="form-control">
						<option value="" selected>Popularity</option>
						<!-- TODO: Fill search options -->
						<option value=""></option>
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
	
</body>
</html>
