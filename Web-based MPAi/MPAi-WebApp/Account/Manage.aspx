<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="MPAi_WebApp.Account.Manage" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div class="container outer padding-top">
		<h2><%: Title %>.</h2>

		<div>
			<asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
				<p class="text-success"><%: SuccessMessage %></p>
			</asp:PlaceHolder>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="form-horizontal">
					<h4>Change your account settings</h4>
					<hr />
					<dl class="dl-horizontal">
						<dt>Password:</dt>
						<dd>
							<asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
							<asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</asp:Content>
