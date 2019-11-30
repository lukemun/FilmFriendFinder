<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<title>Available Film Projects</title>
</head>
<body>
	<%@ include file="Navbar.jsp" %>
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
				<div class="col-sm-1 mt-2 text-center">
					<button type="submit" class="btn btn-dark">Go</button>
				</div>
			</div>
		</form>
	</div>

	<div class="container">
		<div class="row mt-4 mb-4">
			<div class="col-12">
				<!-- TODO: Update with dynamic result number -->
				Results: 5 project(s)
			</div>
		</div>
	</div>
	
	<!-- TODO: Update with dynamic results -->
	<div class="container">
		<div class="row mt-2">
			<div class="col-12">
				<h5>
					<a class="font-weight-bold text-dark" href="Details.jsp">The Godfather</a>
				</h5>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<strong>Date Posted:</strong> November 9, 2019
			</div>
		</div>
		<div class="row">
			<div class="col-3">
				<strong>Genre Tags:</strong> Crime, Drama	
			</div>
			<div class="col-3"> 
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
	</div>
	
	<!-- TODO: Update with dynamic results -->
	<div class="container">
		<div class="row mt-2">
			<div class="col-12">
				<h5>
					<a class="font-weight-bold text-dark" href="">Joker</a>
				</h5>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<strong>Date Posted:</strong> October 19, 2019
			</div>
		</div>
		<div class="row">
			<div class="col-3">
				<strong>Genre Tags:</strong> Crime, Drama, Thriller
			</div>
			<div class="col-3">
				<strong>Rating:</strong> <span class="stars-container stars-80">★★★★★</span>
				<div id="stars-value">80</div>
			</div>
		</div>
		<div class="row mt-1 mb-5">
			<div class="col-12 font-italic">
				In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society. 
				He then embarks on a downward spiral of revolution and bloody crime. 
				This path brings him face-to-face with his alter-ego: the Joker.
			</div>
		</div>
	</div>

	<!-- TODO: Update with dynamic results -->
	<div class="container">
		<div class="row mt-2">
			<div class="col-12">
				<h5>
					<a class="font-weight-bold text-dark" href="">John Wick: Chapter 3 - Parabellum</a>
				</h5>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<strong>Date Posted:</strong> October 19, 2019
			</div>
		</div>
		<div class="row">
			<div class="col-3">
				<strong>Genre Tags:</strong> Crime, Action, Thriller	
			</div>
			<div class="col-3">
				<strong>Rating:</strong> <span class="stars-container stars-80">★★★★★</span>
				<div id="stars-value">80</div>
			</div>
		</div>
		<div class="row mt-1 mb-5">
			<div class="col-12 font-italic">
				John Wick is on the run after killing a member of the international assassin's guild, 
				and with a $14 million price tag on his head, 
				he is the target of hit men and women everywhere.
			</div>
		</div>
	</div>
	
	<!-- TODO: Show all results or implement pagination -->
	<div class="col-12 mt-4">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<li class="page-item">
					<a class="page-link text-dark" href="">First</a>
				</li>
				<li class="page-item">
					<a class="page-link text-dark" href="">Previous</a>
				</li>
				<li class="page-item active">
					<a class="page-link" href="">1</a>
				</li>
				<li class="page-item">
					<a class="page-link text-dark" href="">Next</a>
				</li>
				<li class="page-item">
					<a class="page-link text-dark" href="">Last</a>
				</li>
			</ul>
		</nav>
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
