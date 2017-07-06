<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="UploadRecording.Listen" %>

<!--Some code adapted from http://demo.tutorialzine.com/2015/03/html5-music-player/-->
<!DOCTYPE html>

<html>
<head runat="server">
	<title>MPAi-Listen</title>
	<meta charset="utf-8" />

	<link rel="stylesheet/less" type="text/css" href="css/dropdown.less" />

	<script src='http://code.jquery.com/jquery-1.11.0.min.js' type='text/javascript'></script>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">

	<link href="//vjs.zencdn.net/5.11.6/video-js.min.css" rel="stylesheet">

	<script src="//vjs.zencdn.net/5.11.6/video.min.js"></script>
	<script src="JavaScript/wavesurfer.min.js"></script>
	<script src="//collab-project.github.io/videojs-wavesurfer/dist/videojs.wavesurfer.min.js"></script>
</head>
<body>

	<!--Nvaigation Bar-->
	<nav class="navbar navbar-default navbar-fixed-top" id="navigation">
		<div class="container" style="width: 100%">
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
	<nav class="navbar navbar-default navbar-fixed-top" style="top: 70px;">
		<div class="container">
			<ul class="nav navbar-nav">
				<li><a href="index.aspx">
					<h4>Home</h4>
				</a></li>
				<li><a href="Listen.aspx">
					<h4>Listen</h4>
				</a></li>
				<li><a href="Speak.aspx">
					<h4>Speak</h4>
				</a></li>
				<li><a href="#0">
					<h4>Scoreboard</h4>
				</a></li>
			</ul>
		</div>
	</nav>

	<!--Listen Page Content-->
	<div class="container" style="margin: 0 auto; width: 500px; height: 100px;">
		<section style="padding: 5px;">
			<br />
			<div>
				<label>Category: </label>
				<select id="category">
					<option value="youngfemale">Young Female</option>
					<option value="oldfemale">Old Female</option>
					<option value="youngmale">Young Male</option>
					<option value="oldmale">Old Male</option>
				</select>
				<label for="maoriWord">Maori word:</label>
				<input type="text" id="maoriWord" />
				<button id="search">Search</button>
				<br />
				<label style="color: purple">Please double the vowels to show long vowels.</label>
			</div>
		</section>

		<section style="padding: 5px;">
			<div>
				<p>
					<button id="change">Change</button>
				</p>
			</div>
			<div id="result" style="color: purple"></div>
		</section>

		<%--<input type="text" id="ajax" list="json-datalist" placeholder="Search...">
		<datalist id="json-datalist"></datalist>--%>
	</div>

	<br />
	<br />

	<!--Audio Player-->
	<div id="media-player" class="container" style="width: 80%">
		<audio id="myAudio" class="video-js vjs-default-skin"></audio>
	</div>
	

	<script src="JavaScript/Listen.js"></script>
	
</body>
</html>
