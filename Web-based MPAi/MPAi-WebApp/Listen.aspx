<%@ Page Title="Listen" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="MPAi_WebApp.Listen" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Listen Page Content-->
	<div class="container" style="margin: 0 auto;">
		<section style="padding: 5px;">
			<div class="container inner">
				
				<label for="maoriWord">Maori word:</label>
				<div id="search-bar" class="input-group input-group-lg">
					<input id="maoriWord" class="form-control" autofocus type="text" name="q" placeholder="Search...">

					<span class="input-group-btn">
						<input id="search" class="btn btn-default" type="button" value="Go!" />
					</span>
				</div>
				<label>Category: </label>
				<select id="category" class="form-control">
					<option value="youngfemale">Young Female</option>
					<option value="oldfemale">Old Female</option>
					<option value="youngmale">Young Male</option>
					<option value="oldmale">Old Male</option>
				</select>
				<div class='wrapper text-center'>
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default active" style="width:auto; padding:0px">
							<input type="radio" name="inputWalls" value="YoungFemale" checked>
							<img src="Resources/Emotikis/YoungFemale.png" />
						</label>
						<label class="btn btn-default" style="width:auto; padding:0px">
							<input type="radio" name="inputWalls" value="YoungMale">
							<img src="Resources/Emotikis/YoungMale.png" />
						</label>
						<label class="btn btn-default" style="width:auto; padding:0px">
							<input type="radio" name="inputWalls" value="OldFemale">
							<img src="Resources/Emotikis/OldFemale.png" />
						</label>
						<label class="btn btn-default" style="width:auto; padding:0px">
							<input type="radio" name="inputWalls" value="OldMale">
							<img src="Resources/Emotikis/OldMale.png" />
						</label>
					</div>
				</div>
			</div>
		</section>

		<section style="padding: 5px;">
			<div>
				<p>
					<input type="button" id="change" value="Change" />
				</p>
			</div>
			<div id="result" style="color: purple"></div>
		</section>

		<section style="padding: 5px;">
			<!--Audio Player-->
			<audio id="myAudio" class="video-js vjs-default-skin"></audio>
		</section>
	</div>


	<script src="JavaScript/jquery.auto-complete.js"></script>
	<script src="JavaScript/dropdown.js"></script>
	<script src="JavaScript/Listen.js"></script>
</asp:Content>
