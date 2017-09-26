<%@ Page Title="Listen" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="MPAi_WebApp.Listen" %>

<%-- This page is the Listen page where users can listen to recordings of Maori words.
	It uses main.js and Listen.js JavaScript files to implement dynamic behaviour. --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Listen Page Content-->

	<%-- This section is the initially displayed section containing the word and category selection --%>
	<section class="padding-top">
		<div class="container outer">
			<div class="inner">

				<h3 style="text-align: center;">Select a M&#257;ori word to listen</h3>

				<%-- Word selection --%>
				<div id="search-bar" class="input-group input-group-lg">
					<%-- The search bar which is disabled and says "Loading words..." on initialisation.
						The javascript code in main.js and Listen.js are responsible for declaring the functionality of the search bar. --%>
					<input id="maoriWord" class="form-control" type="text" placeholder="Loading words..." disabled>

					<%-- The search button --%>
					<span class="input-group-btn">
						<button id="search" type="button" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
					</span>
				</div>
				<%-- Message that shows up if users don't select a valid word --%>
				<h5 id="searchErrorMessage" class="collapse" style="text-align: center; color: #FF6461;"></h5>
			</div>

			<hr />

			<%-- Category selection --%>
			<h3 style="text-align: center;">Choose a category</h3>

			<%-- Radio buttons with Modern Female set as the default --%>
			<div id="category" class='wrapper text-center'>
				<div class="btn-group" data-toggle="buttons">
					<label class="emotiki btn btn-default active" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="MODERN_FEMALE" checked>
						<img src="Resources/Emotikis/YoungFemale.png" />
						Modern Female
					</label>
					<label class="emotiki btn btn-default" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="MODERN_MALE">
						<img src="Resources/Emotikis/YoungMale.png" />
						Modern Male
					</label>
					<label class="emotiki btn btn-default" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="KUIA_FEMALE">
						<img src="Resources/Emotikis/OldFemale.png" />
						Kuia Female
					</label>
					<label class="emotiki btn btn-default" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="KAUMATUA_MALE">
						<img src="Resources/Emotikis/OldMale.png" />
						Kaum&#257;tua Male
					</label>
				</div>
			</div>
		</div>
	</section>

	<%-- This section is a collapsable section containing the media player and any results from the search query --%>
	<section id="listen" class="padding-bottom collapse">
		<div class="container outer">

			<%-- The result text and change recording button --%>
			<div style="margin-bottom: 20px; text-align: center;">
				<%-- Change recording button only shows up if more than one recording is available for the search --%>
				<button id="change" type="button" class="btn btn-info" style="margin: 0px auto 0px auto; font-size: 20px;">Click</button>
				<%-- Result Text --%>
				<h3 id="result" style="text-align: center; display: inline-block; vertical-align: bottom;"></h3>
			</div>

			<div id="recordings" class="collapse">
				<!--Audio Player-->
				<audio id="myAudio" class="video-js vjs-default-skin"></audio>
			</div>
		</div>
	</section>

	<!--References-->
	<link href="Content/video-js.min.css" rel="stylesheet">
	<link rel="stylesheet" href="Content/jquery.auto-complete.css">

	<script src="JavaScript/video.min.js"></script>

	<script src="JavaScript/wavesurfer.min.js"></script>
	<script src="JavaScript/videojs.wavesurfer.min.js"></script>

	<script src="JavaScript/jquery.auto-complete.js"></script>
	<script src="JavaScript/main.js"></script>
	<script src="JavaScript/Listen.js"></script>
	<link rel="stylesheet" type="text/css" href="Content/style.css">
</asp:Content>
