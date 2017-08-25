<%@ Page Title="Listen" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="MPAi_WebApp.Listen" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Listen Page Content-->
	<section class="padding-top">
		<div class="container outer">
			<div class="inner">

				<h3 style="text-align: center;">Select a M&#257;ori word to listen</h3>
				<div id="search-bar" class="input-group input-group-lg">
					<input id="maoriWord" class="form-control" type="text" name="q" placeholder="Loading words..." disabled>

					<span class="input-group-btn">
						<button id="search" type="button" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
					</span>
				</div>
				<h5 id="searchErrorMessage" class="collapse" style="text-align: center; color: #FF6461;"></h5>

				<hr />

				<h3 style="text-align: center;">Choose a category</h3>

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
		</div>
	</section>

	<section id="listen" class="padding-bottom collapse">
		<div class="container outer">

			<ul class="pager" style="display:flex;">
				<li class="previous col-xs-2">
					<button id="previous" type="button" class="btn btn-info" style="width: auto; float: left; height: 100%;"><span aria-hidden="true">&larr;</span></button>
				</li>
				<li class="col-xs-8" style="vertical-align: text-bottom;">
					<h3 id="result" style="text-align: center"></h3>
				</li>
				<li class="next col-xs-2">
					<button id="next" type="button" class="btn btn-info" style="width: auto; float: right; height: 100%;"><span aria-hidden="true">&rarr;</span></button>
				</li>
			</ul>

			<div id="recordings" class="collapse">
				<button id="change" type="button" class="btn btn-info btn-wide" disabled>Change Speaker</button>

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
	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Listen.js"></script>
	<link rel="stylesheet" type="text/css" href="Content/style.css">
</asp:Content>
