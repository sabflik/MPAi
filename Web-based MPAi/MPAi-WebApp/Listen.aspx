<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="MPAi_WebApp.Listen" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Listen Page Content-->
	<div class="container" style="margin: 0 auto;">
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
				<input type="text" id="maoriWord" list="json-datalist" placeholder="Search...">
				<datalist id="json-datalist"></datalist>
				<input type="button" id="search" value="Search"/>
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

		<!--Audio Player-->
		<div id="media-player" class="container" style="width: 80%">
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>
		</div>
	</div>



	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Listen.js"></script>
</asp:Content>
