<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Speak.aspx.cs" Inherits="UploadRecording.Speak" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">
	<title>MPAi-Speak</title>

	<script src='http://code.jquery.com/jquery-1.11.0.min.js' type='text/javascript'></script>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">

	<link href="//vjs.zencdn.net/5.11.6/video-js.min.css" rel="stylesheet">
	<link href="https://collab-project.github.io/videojs-record/dist/css/videojs.record.min.css" rel="stylesheet">

	<script src="//vjs.zencdn.net/5.11.6/video.min.js"></script>

	<script src="JavaScript/recorder.js"></script>
	<script src="JavaScript/wavesurfer.min.js"></script>
	<script src="//collab-project.github.io/videojs-wavesurfer/dist/wavesurfer.microphone.min.js"></script>
	<script src="//collab-project.github.io/videojs-wavesurfer/dist/videojs.wavesurfer.min.js"></script>

	<script src="JavaScript/videojs.record.js"></script>
	<script src="JavaScript/videojs.record.recorderjs.js"></script>

	<style>
		/* place fullscreen control on right side of the player */
		.video-js .vjs-control.vjs-fullscreen-control {
			position: absolute;
			right: 0;
		}

		/* make sure the custom controls are always visible because
   the plugin hides and replace the video.js native mobile
   controls */
		.vjs-using-native-controls .vjs-control-bar {
			display: flex !important;
		}

		input {
			border: 1px solid rgb(49, 79, 79);
			border-radius: 3px;
			font-size: 1em;
			width: 100px;
			text-align: center;
		}

		button {
			border: 1px solid rgb(49, 79, 79);
			border-radius: 3px;
			vertical-align: middle;
			height: auto;
			font-size: inherit;
		}
	</style>
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

	<!--Speak Page Content-->
	<div class="container" style="margin: 0 auto;">

		<section class="experiment" style="padding: 5px;">
			<br />
			<label for="maoriWord">Your Maori word to pronounce:</label>
			<input type="text" id="maoriWord" list="json-datalist" placeholder="Search...">
			<datalist id="json-datalist"></datalist>
			<label id="alertWord" style="color: red"></label>
			<br />
			<label style="color: purple">Please double the vowels to show long vowels.</label>
			<br />
			<br />
			<button id="analyse-recording" disabled>Analyse</button>
			<button id="save-recording" disabled>Download</button>
		</section>

		<section class="experiment" style="padding: 5px;">
			<div id="audios-container"></div>
			<audio id="recording"></audio>
			<label id="edgeNotice" style="color: green;"></label>
		</section>
		<section class="experiment" style="padding: 5px;">
			<div id="result" style="color: purple"></div>
		</section>

		<!--Audio Player-->
		<div id="media-player" class="container" style="width: 80%">
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>
		</div>
	</div>

	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Speak.js"></script>

</body>
</html>
