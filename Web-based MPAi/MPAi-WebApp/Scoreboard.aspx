<%@ Page Title="Soreboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scoreboard.aspx.cs" Inherits="MPAi_WebApp.Scoreboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Scoreboard content-->
    <div class="container" style="margin: 0 auto;">

		<section style="padding: 5px;">
			<br />
			<div>
				<label>Your current score:</label>
				<canvas id="doughnut"></canvas>
			</div>
		</section>
    </div>

	<script src="JavaScript/Chart.bundle.js"></script>
	<script src="JavaScript/Scoreboard.js"></script>
</asp:Content>
