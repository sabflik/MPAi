<%@ Page Title="Speak" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Speak.aspx.cs" Inherits="MPAi_WebApp.Speak" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Speak Page Content-->
	<section id="word-search" class="padding-top">
		<div class="container outer">
			<div class="inner">
				
				<h3 style="text-align:center;">Select a M&#257;ori word to pronounce</h3>

				<div id="search-bar" class="input-group input-group-lg">
					<input id="maoriWord" class="form-control" type="text" name="q" placeholder="Search...">

					<span class="input-group-btn">
						<button id="search" type="button" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
					</span>
				</div>

				<h5 id="searchErrorMessage" class="collapse" style="color: #FF6461;"></h5>

			</div>
		</div>
	</section>

	<section id="record" class="padding-bottom collapse">
		<div class="container outer">
			<h3 id="recordMessage" style="text-align:center;"></h3>

			<!--Audio Player-->
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>

			<h5>Hint: Double the length of vowels to show long vowels.</h5>

			<!-- Analyse button -->
			<button id="analyse" type="button" class="btn btn-info btn-lg" disabled>Analyse</button>
		</div>
	</section>

	<!--Modal Score Report-->
	<div id="score-report" class="modal" role="dialog">
		<div class="modal-dialog">

			<!-- Score Report content-->
			<div class="modal-content">
				<div id="score-header" class="modal-header">
					<button type="button" class="close" data-dismiss="modal" style="color: white; opacity: 1;">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div id="score-body" class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Okay</button>
				</div>
			</div>

		</div>
	</div>

	<!--References-->
	<link href="Content/video-js.min.css" rel="stylesheet">
	<link href="Content/videojs.record.min.css" rel="stylesheet">
	<link rel="stylesheet" href="Content/jquery.auto-complete.css">

	<script src="JavaScript/video.min.js"></script>

	<script src="JavaScript/recorder.js"></script>
	<script src="JavaScript/wavesurfer.min.js"></script>
	<script src="JavaScript/wavesurfer.microphone.min.js"></script>
	<script src="JavaScript/videojs.wavesurfer.min.js"></script>

	<script src="JavaScript/videojs.record.js"></script>
	<script src="JavaScript/videojs.record.recorderjs.js"></script>

	<script src="JavaScript/jquery.auto-complete.js"></script>
	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Speak.js"></script>
	<link rel="stylesheet" type="text/css" href="Content/style.css">
</asp:Content>
