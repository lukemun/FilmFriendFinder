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
	<title>Login</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
	<div class="container">
		<div class="row">
			<h1 class="col-12 mt-4 mb-4">Login</h1>
		</div>
	</div>
	<div class="container">
		<form action="Login" class="needs-validation" novalidate>
			<div class="form-group">
    			<label for="uname">Username</label>
    			<input type="text" class="form-control" id="uname" placeholder="username(email)" name="uname" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter username.</div>
  			</div>
  			<div class="form-group">
    			<label for="pwd">Password</label>
    			<input type="password" class="form-control" id="pwd" placeholder="password" name="pswd" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter password.</div>
  			</div>
  			<button type="submit" class="btn btn-dark">Login</button>
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
</script>
	
</body>

</html>
