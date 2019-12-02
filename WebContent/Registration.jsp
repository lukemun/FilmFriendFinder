<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<title>Registration</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
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
	    		<input type="text" class="form-control" id="position" placeholder="Position(s) Interested In" name="position">
	  		</div>
	  		<div class="form-group">
	    		<input type="text" class="form-control" id="prefproj" placeholder="Preferred Project(s)" name="prefproj">
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
//Allows the name of the file to appear on select 
$(".custom-file-input").on("change", function() {
	var fileName = $(this).val().split("\\").pop();
	$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});
</script>
	
</body>
</html>