<%@ Page Title="Speak" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Speak.aspx.cs" Inherits="MPAi_WebApp.Speak" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Speak Page Content-->
	<div class="container page-content" style="margin: 0 auto;">

		<section class="experiment" style="padding: 5px;">
			<div class="container inner">
				<h4>Select a Maori word to pronounce</h4>
				<div id="search-bar" class="input-group input-group-lg">
					<input id="maoriWord" class="form-control" autofocus type="text" name="q" placeholder="Search...">

					<span class="input-group-btn">
						<input id="search" class="btn btn-default" type="button" value="Go!" />
					</span>
				</div>
			</div>
		</section>

		<section style="padding: 5px;">
			<div class="container inner">
				<h4 id="message"></h4>
				<h5>Hint: Double the length of vowels to show long vowels.</h5>
			</div>
		</section>

		<section style="padding: 5px;">
			<div class="container inner">
				<!--Audio Player-->
				<audio id="myAudio" class="video-js vjs-default-skin"></audio>

				<!-- Analyse button -->
				<button id="analyse" type="button" class="btn btn-info btn-lg" disabled>Analyse</button>
			</div>
		</section>

	</div>

	<!--Modal Score Report-->
	<div id="score-report" class="modal" role="dialog">
		<div class="modal-dialog">

			<!-- Score Report content-->
			<div class="modal-content">
				<div id="score-header" class="modal-header">
					<button type="button" class="close" data-dismiss="modal" style="color:white; opacity:1;">&times;</button>
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

	<script src="JavaScript/jquery.auto-complete.js"></script>
	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Speak.js"></script>
</asp:Content>
