<%@ Page Title="Scoreboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scoreboard.aspx.cs" Inherits="MPAi_WebApp.Scoreboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Scoreboard content-->
	<section class="padding-top padding-bottom">
		<div class="container" style="min-width: 300px;">
			<div class="row">
				<div class="col-xs-12 col-sm-8">
					<div id="timeScaleParent" class="chart">
						<h3 style="text-align: center;">Progress Over Time</h3>
						<div class="form-group">
							<h4>See progress for:</h4>
							<select class="form-control" id="timeUnit">
								<option>past day</option>
								<option selected>past month</option>
								<option>past year</option>
							</select>
						</div>
					</div>
				</div>
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
	<script src="JavaScript/Scoreboard.js"></script>
</asp:Content>
