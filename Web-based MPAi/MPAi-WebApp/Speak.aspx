<%@ Page Title="Speak" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Speak.aspx.cs" Inherits="MPAi_WebApp.Speak" %>

<%-- This page is the Speak page where users can record and analyse their pronunciation of Maori words.
	It uses main.js and Speak.js JavaScript files to implement dynamic behaviour. --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Speak Page Content-->

	<%-- This section is the initially displayed section containing the word selection --%>
	<section id="word-search" class="padding-top">
		<div class="container outer">
			<div class="inner">
				
				<h3 style="text-align:center;">Select a M&#257;ori word to pronounce</h3>

				<%-- Word selection --%>
				<div id="search-bar" class="input-group input-group-lg">
					<%-- The search bar which is disabled and says "Loading words..." on initialisation.
						The javascript code in main.js and Speak.js are responsible for declaring the functionality of the search bar. --%>
					<input id="maoriWord" class="form-control" type="text" name="q" placeholder="Loading words..." disabled>

					<%-- The search button --%>
					<span class="input-group-btn">
						<button id="search" type="button" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
					</span>
					<%-- A preview button that can be used to listen to a recording of the word without having to switch pages --%>
					<span class="input-group-btn">
						<button id="preview" type="button" class="btn btn-default"><span class="glyphicon glyphicon-volume-up"></span></button>
					</span>
					<%-- The audio element for loading the preview recording --%>
					<audio id="previewMedia"></audio>
				</div>
				<%-- Message that shows up if users don't select a valid word --%>
				<h5 id="searchErrorMessage" class="collapse" style="color: #FF6461;"></h5>

			</div>
		</div>
	</section>

	<%-- This section is a collapsable section containing the media player for recording --%>
	<section id="record" class="padding-bottom collapse">
		<div class="container outer">
			<%-- Message for prompting the user to record a given word --%>
			<h3 id="recordMessage" style="text-align:center;"></h3>

			<!--Audio Player-->
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>

			<br />

			<!-- Analyse button -->
			<button id="analyse" type="button" class="btn btn-info btn-lg btn-wide">Analyse</button>
		</div>
	</section>

	<!--Modal Score Report that displays the analysis results-->
	<div id="score-report" class="modal" role="dialog">
		<div class="modal-dialog">

			<!-- The score report content is dynamically generated in the Speak.js file-->
			<div class="modal-content">
				<div id="score-header" class="modal-header">
					<%-- Close button --%>
					<button type="button" class="close" data-dismiss="modal" style="color: white; opacity: 1;">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div id="score-body" class="modal-body">
				</div>
				<div class="modal-footer">
					<%-- Okay button --%>
					<button type="button" class="btn btn-default btn-wide" style="background-color: #f8f8f8;" data-dismiss="modal">Okay</button>
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
	<script src="JavaScript/main.js"></script>
	<script src="JavaScript/Speak.js"></script>
	<link rel="stylesheet" type="text/css" href="Content/style.css">
</asp:Content>
