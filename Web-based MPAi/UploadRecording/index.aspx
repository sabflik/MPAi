<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="UploadRecording.index" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">
	<title>MPAi</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">

	<!-- Gem jQuery -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<script src="JavaScript/main.js"></script>
</head>

<body>

	<!--Nvaigation Bar-->
	<nav class="navbar navbar-default navbar-fixed" id="navigation">
		<div class="container">
			<div class="navbar-header">
				<a href="index.aspx">
					<img id="headerLogo" src="Resources/headerImage.png" alt="MPAi: A Maori Pronunciation Aid">
				</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#0" id="loginButton">Login</a></li>
				<li><a href="#0" id="signUpButton">Sign Up</a></li>
			</ul>
		</div>
	</nav>

	<!--Modal Login/SignUp forms-->
	<div class="modal" id="modal-forms">
		<div class="modal-content">
			<ul class="cd-switcher">
				<li><a href="#0">Login</a></li>
				<li><a href="#0">Sign Up</a></li>
			</ul>
			<!-- log in form -->
			<div id="cd-login">
				<form class="form-signin" action="Speak.aspx" method="post">

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
						<input type="text" class="form-control" placeholder="Enter Username" name="user" required>
					</div>

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
						<input type="password" class="form-control" placeholder="Enter Password" name="pass" required>
					</div>

					<div class="checkbox input-group">
						<label>	<input type="checkbox" value="remember">Remember Me</label>
					</div>

					<input class="btn btn-lg btn-block btn-red" type="submit" value="Login">
				</form>
			</div>
			<!-- sign up form -->
			<div id="cd-signup">
				<form class="form-signin" action="Speak.aspx" method="post">

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
						<input type="text" class="form-control" placeholder="Enter Username" name="user" required>
					</div>

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
						<input type="password" class="form-control" placeholder="Enter Password" name="pass" required>
					</div>

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
						<input type="password" class="form-control" placeholder="Confirm Password" name="confirmPass" required>
					</div>

					<h4>My voice is</h4>

					<div class="btn-group inline" data-toggle="buttons" style="width:100%;">
						<label class="btn btn-lg" style="color:dodgerblue; width:50%;">
							<input type="radio" name="options" id="masculine" >Masculine
						</label>
						<label class="btn btn-lg" style="color:hotpink; width:50%;">
							<input type="radio" name="options" id="feminine">Feminine
						</label>
					</div>
					<p>*This can be changed later from the Settings menu</p>

					<input class="btn btn-lg btn-block btn-red" type="submit" value="Sign Up">
				</form>
			</div>
		</div>
	</div>

	<!--Home Page content-->
	<div id="wrapper" class="container">
		<div id="main-content" class="container">
			Something
		</div>
	</div>
</body>
</html>
