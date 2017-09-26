<%@ Page Title="Scoreboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scoreboard.aspx.cs" Inherits="MPAi_WebApp.Scoreboard" %>

<%-- This page is the Scoreboard page where users can view their scores and track their progress over time.
	It uses main.js and Scoreboard.js JavaScript files to implement dynamic behaviour. --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Scoreboard content-->

	<%-- This section contains the graphs. All graphs are drawn with the Chart.js library. --%>
	<section class="padding-top padding-bottom">
		<div class="container" style="min-width: 300px;">
			<div class="row">
				<%-- Time Scale Graph --%>
				<%-- The col-sm-4 class ensures that time scale will take up two thirds of the width on tablets and larger screens --%>
				<%-- The col-xs-12 class ensures that time scale will take up the full column width on mobile phones --%>
				<%-- This graph is dynamically created through the Scoreboard.js file --%>
				<div class="col-xs-12 col-sm-8">
					<div id="timeScaleParent" class="chart">
						<h3 style="text-align: center;">Progress Over Time</h3>
						<div class="form-group">
							<h4>See progress for:</h4>
							<%-- Dropdown to change time period --%>
							<select class="form-control" id="timeUnit">
								<option>past day</option>
								<option selected>past month</option>
								<option>past year</option>
							</select>
						</div>
					</div>
				</div>
				<%-- Doughnut Graph --%>
				<%-- The col-sm-4 class ensures that doughnut will take up one third of the width on tablets and larger screens --%>
				<%-- The col-xs-12 class ensures that doughnut will take up the full column width on mobile phones --%>
				<div class="col-xs-12 col-sm-4">
					<div class="chart">
						<h3 style="text-align:center;">Average Score</h3>
						<canvas id="doughnut"></canvas>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js"></script>
	<script src="JavaScript/Chart.bundle.js"></script>
	<script src="JavaScript/main.js"></script>
	<script src="JavaScript/Scoreboard.js"></script>
</asp:Content>
