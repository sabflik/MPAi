<%@ Page Title="Soreboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scoreboard.aspx.cs" Inherits="MPAi_WebApp.Scoreboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Scoreboard content-->
    <div class="container" style="margin: 0 auto;">

		<section style="padding: 5px;">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-8">
						<div class="chart">
							<label>Your progress:</label>
							<canvas id="timeScale"></canvas>
						</div>
					</div>
					<div class="col-xs-12 col-sm-4">
						<div class="chart">
							<label>Your current score:</label>
							<canvas id="doughnut"></canvas>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section style="padding: 5px;">
			
		</section>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js"></script>
	<script src="JavaScript/Chart.bundle.js"></script>
	<script src="JavaScript/Scoreboard.js"></script>
</asp:Content>
