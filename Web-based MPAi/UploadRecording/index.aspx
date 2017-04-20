<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="UploadRecording.index" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">
	<title>MPAi</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

	<style>
		* {	border-radius: 0 !important; }

		#navigation > .container {
			margin-right: auto;
			margin-left: auto;
			height: 150px;
		}

		#headerLogo {
			display: block;
			margin: auto;
			height: 100%;
		}

		#wrapper {
			margin-right: auto;
			margin-left: auto;
		}

		.form-signin {
			max-width: 330px;
			padding: 15px;
			margin: 0 auto;
		}

			.form-signin .form-control {
				position: relative;
				height: auto;
				padding: 10px;
				font-size: 16px;
			}

		.input-group {
			margin: 5px;
		}

		#loginLogo {
			display: block;
			margin: auto;
		}

		.card-container.card {
			max-width: 350px;
			padding: 40px 40px;
			margin: 0 auto;
		}

		.card {
			background-color: #F7F7F7;
			padding: 20px 25px 30px;
			margin: 0 auto 25px;
			margin-top: 50px;
		}

		.btn {
			background-color: #AB0F12;
		}
		.btn:hover {
			background-color: #000000;
		}
	</style>
</head>

<body>

	<!--Nvaigation Bar-->
	<nav class="navbar navbar-default " id="navigation">
		<div class="container">
			<img id="headerLogo" src="Resources/header.png">
		</div>
	</nav>

	<div id="wrapper" class="container">
		<div class="card card-container">
			<img id="loginLogo" src="Resources/LoginLogo.png" width="150">

			<form class="form-signin" action="Speak.aspx" method="post">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
					<input type="text" class="form-control" placeholder="Enter Username" name="user" required>
				</div>

				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
					<input type="password" class="form-control" placeholder="Enter Password" name="pass" required>
				</div>
				<input class="btn btn-lg btn-primary btn-block" type="submit" value="Login">
				<a href="#" class="btn btn-lg btn-primary btn-block">Register</a>
			</form>
		</div>
	</div>
</body>
</html>
