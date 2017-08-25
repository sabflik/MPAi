<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lockout.aspx.cs" Inherits="MPAi_WebApp.Account.Lockout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<div class="container outer padding-top">
		<hgroup>
			<h1>Locked out.</h1>
			<h2 class="text-danger">This account has been locked out, please try again later.</h2>
		</hgroup>
	</div>
</asp:Content>
