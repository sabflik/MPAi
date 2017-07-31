<%@ Page Title="Listen" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="MPAi_WebApp.Listen" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Listen Page Content-->
	<section>
		<div class="container inner">

			<h4>Select a Maori word to listen</h4>
			<div id="search-bar" class="input-group input-group-lg">
				<input id="maoriWord" class="form-control" type="text" name="q" placeholder="Search...">

				<span class="input-group-btn">
					<input id="search" class="btn btn-default" type="button" value="Go!" />
				</span>
			</div>
			<h4>Choose a category</h4>

			<div id="category" class='wrapper text-center'>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default active" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="MODERN_FEMALE" checked>
						<img src="Resources/Emotikis/YoungFemale.png" />
						Modern Female
					</label>
					<label class="btn btn-default" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="MODERN_MALE">
						<img src="Resources/Emotikis/YoungMale.png" />
						Modern Male
					</label>
					<label class="btn btn-default" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="KUIA_FEMALE">
						<img src="Resources/Emotikis/OldFemale.png" />
						Kuia Female
					</label>
					<label class="btn btn-default" style="width: auto; padding: 0px">
						<input type="radio" name="category" value="KAUMATUA_MALE">
						<img src="Resources/Emotikis/OldMale.png" />
						Kaumatua Male
					</label>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container inner">
			<h4 id="result" style="text-align: center"></h4>
			<button id="change" type="button" class="btn btn-default" disabled>Change Speaker</button>
		</div>
	</section>

	<section>
		<div class="container inner">
			<!--Audio Player-->
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>
		</div>
	</section>


	<script src="JavaScript/jquery.auto-complete.js"></script>
	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Listen.js"></script>
</asp:Content>
