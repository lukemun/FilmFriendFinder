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
		<form action="" class="needs-validation" novalidate>
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
  				<label for="genre-id">Genre Tags</label>
    			<select name="genre" class="form-control" id="genre-id" name="genre-id" required>
				<option selected>Genre Tags</option>
				<!-- TODO: Fill search options -->
				<option value=""></option>
				</select>	
				<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please select genre.</div>
  			</div>
  			<div class="form-group">
    			<label for="position">Position(s) You're Looking For</label>
    			<input type="text" class="form-control" id="postion" placeholder="Position(s) You're Looking For" name="position" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter the position(s) you're looking for.</div>
  			</div>
  			<button type="submit" class="btn btn-dark">Submit</button>
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
