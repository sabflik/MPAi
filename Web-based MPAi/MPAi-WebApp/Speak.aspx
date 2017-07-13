<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Speak.aspx.cs" Inherits="MPAi_WebApp.Speak" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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
</asp:Content>
