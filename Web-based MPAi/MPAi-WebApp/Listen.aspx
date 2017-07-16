<%@ Page Title="Listen" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="MPAi_WebApp.Listen" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Listen Page Content-->
	<div class="container" style="margin: 0 auto;">
		<section style="padding: 5px;">
			<div class="container">
				<label>Category: </label>
				<select id="category">
					<option value="youngfemale">Young Female</option>
					<option value="oldfemale">Old Female</option>
					<option value="youngmale">Young Male</option>
					<option value="oldmale">Old Male</option>
				</select>
				<label for="maoriWord">Maori word:</label>
				<div id="search-bar" class="input-group input-group-lg">
					<%--<div class="input-group-btn">
						
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Category <span class="caret"></span></button>--%>
						<%--<img id="category-dropdown" class="btn dropdown-toggle" src="Resources/Emotikis/YoungFemale.png" alt="dropdown image" data-toggle="dropdown">--%>
						<%--<ul class="dropdown-menu">
							<li><a href="#">Young Female</a></li>
							<li><a href="#">Young Male</a></li>
							<li><a href="#">Old Female</a></li>
							<li><a href="#">Old Male</a></li>
						</ul>
					</div>--%>
					<input id="maoriWord" class="form-control" autofocus type="text" name="q" placeholder="Search...">

					<span class="input-group-btn">
						<input id="search" class="btn btn-default" type="button" value="Go!" />
					</span>
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
