<%@ Page Title="Soreboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scoreboard.aspx.cs" Inherits="MPAi_WebApp.Scoreboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--Scoreboard content-->
    <div class="container">
		<canvas id="myChart" width="400" height="400"></canvas>
    
    </div>

	<script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.js"></script>
	<script src="JavaScript/Scoreboard.js"></script>
</asp:Content>
