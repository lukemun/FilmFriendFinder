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
	
	<h1>Register</h1>
	<form action="Registration" class="needs-validation" novalidate>
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
    		<input type="text" class="form-control" id="email" placeholder="USC Email" name="email" required>
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
    		<input type="text" class="form-control" id="position" placeholder="Position(s) Interested In" name="position" required>
    		<div class="valid-feedback"></div>
    		<div class="invalid-feedback">Please enter the position(s) you're interested in.</div>
  		</div>
  		<div class="form-group">
    		<input type="text" class="form-control" id="prefproj" placeholder="Preferred Project(s)" name="prefproj" required>
    		<div class="valid-feedback"></div>
    		<div class="invalid-feedback">Please enter your preferred project(s).</div>
  		</div>
  		<button type="submit" class="btn btn-primary">Submit</button>
	</form>

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
