<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="UploadRecording.index" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">
	<title>MPAi</title>

	<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>-->

	<script src='http://code.jquery.com/jquery-1.11.0.min.js' type='text/javascript'></script>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<script src='JavaScript/main.js' type='text/javascript'></script>
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

	<!--Home Page content-->
	<div id="wrapper" class="container">
		<div id="main-content" class="container">
			<section>
				<div class="container" style="width: auto;">
					<div class="row">
						<div class="col-sm-6 col-md-4">
							<a href="Listen.aspx">
								<div class="menu-card">
									<img src="Resources/Sound-Music-icon.png" alt="Pattern" />
									<h2>Listen</h2>
									<p class="menu-description">Listen and learn to pronounce common Maori words and phrases</p>
								</div>
							</a>
						</div>
						<div class="col-sm-6 col-md-4">
							<a href="Speak.aspx">
								<div class="menu-card">
									<img src="Resources/Microphone-icon.png" alt="Pattern" />
									<h2>Speak</h2>
									<p class="menu-description">Test your Maori pronunciation skills and receive feedback</p>
								</div>
							</a>
						</div>
						<div class="col-sm-6 col-md-4">
							<a>
								<div class="menu-card">
									<img src="Resources/Document-icon.png" alt="Pattern" />
									<h2>Scoreboard</h2>
									<p class="menu-description">See your progress and view your pronunciation history</p>
								</div>
							</a>
						</div>
					</div>
				</div>
			</section>

			<section>
				<div id="about-content" class="container">
					<h1>About MPAi</h1>
					<p>
						"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
					</p>

					<p>
						"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
					</p>

					<p>
						"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
					</p>
				</div>

			</section>
		</div>
	</div>

	<!--Modal Login/SignUp forms-->
	<div class="modal" id="modal-forms">
		<div class="modal-content">
			<ul class="cd-switcher">
				<li><a href="#0">Login</a></li>
				<li><a href="#0">Sign Up</a></li>
			</ul>
			<!-- log in form -->
			<div id="cd-login">
				<form class="form-signin" action="#0" method="post">

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
						<input type="text" class="form-control" placeholder="Enter Username" name="user" required>
					</div>

					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
						<input type="password" class="form-control" placeholder="Enter Password" name="pass" required>
					</div>

					<div class="checkbox input-group">
						<label>
							<input type="checkbox" value="remember">Remember Me</label>
					</div>

					<input class="btn btn-lg btn-block btn-red" type="submit" value="Login">
				</form>
			</div>
			<!-- sign up form -->
			<div id="cd-signup">
				<form class="form-signin" action="#0" method="post">

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

					<div class="btn-group inline" data-toggle="buttons" style="width: 100%;">
						<label class="btn btn-lg" style="color: dodgerblue; width: 50%;">
							<input type="radio" name="options" id="masculine">Masculine
						</label>
						<label class="btn btn-lg" style="color: hotpink; width: 50%;">
							<input type="radio" name="options" id="feminine">Feminine
						</label>
					</div>
					<p>*This can be changed later from the Settings menu</p>

					<input class="btn btn-lg btn-block btn-red" type="submit" value="Sign Up">
				</form>
			</div>
		</div>
	</div>
</body>
</html>
