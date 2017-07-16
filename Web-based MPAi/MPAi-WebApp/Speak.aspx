<%@ Page Title="Speak" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Speak.aspx.cs" Inherits="MPAi_WebApp.Speak" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Speak Page Content-->
	<div class="container" style="margin: 0 auto;">

		<section class="experiment" style="padding: 5px;">
			<label for="maoriWord">Your Maori word to pronounce:</label>
			<div id="search-bar" class="input-group input-group-lg">
					<input id="maoriWord" class="form-control" autofocus type="text" name="q" placeholder="Search...">

					<span class="input-group-btn">
						<input id="search" class="btn btn-default" type="button" value="Go!" />
					</span>
				</div>
			<label id="alertWord" style="color: red"></label>
			<br />
			<label style="color: purple">Please double the vowels to show long vowels.</label>
		</section>

		<section class="experiment" style="padding: 5px;">
			<div id="audios-container"></div>
			<audio id="recording"></audio>
			<label id="edgeNotice" style="color: green;"></label>
		</section>
		<section class="experiment" style="padding: 5px;">
			<div id="result" style="color: purple"></div>
		</section>

		<section style="padding: 5px;">
			<!--Audio Player-->
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>
		</section>
	</div>

	<script src="JavaScript/jquery.auto-complete.js"></script>
	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Speak.js"></script>
</asp:Content>
