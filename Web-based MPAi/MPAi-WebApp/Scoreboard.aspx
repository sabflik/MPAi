<%@ Page Title="Soreboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scoreboard.aspx.cs" Inherits="MPAi_WebApp.Scoreboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Scoreboard content-->
    <div class="container page-content" style="margin: 0 auto;">

		<section style="padding: 5px;">
			<div class="container" style="min-width: 300px;">
				<div class="row">
					<div class="col-xs-12 col-sm-8">
						<div class="chart">
							<label>My progress:</label>
							<canvas id="timeScale"></canvas>
						</div>
					</div>
					<div class="col-xs-12 col-sm-4">
						<div class="chart">
							<label>My current score:</label>
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
