<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MPAi_WebApp._Default" %>

<%-- This page is the default home page  --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<!--Home Page content-->

	<%-- The first section contains the menu cards linking to the Listen, Speak, and Scoreboard screens --%>
	<section id="section-1" class="padding-top padding-bottom">
		<%-- The col-sm-4 class ensures that menu cards will take up a third of the width on tablets and larger screens --%>
		<%-- The col-xs-12 class ensures that menu cards will take up the full column width on mobile phones --%>
		<div class="container outer">
			<div class="row">
				<%-- Menu card for Listen --%>
				<div class="col-xs-12 col-sm-4">
					<a href="Listen.aspx">
						<div class="menu-card">
							<img src="Resources/Sound-Music-icon.png" alt="Pattern" />
							<h2>Listen</h2>
							<p class="menu-description">Listen and learn to pronounce common M&#257;ori words and phrases</p>
						</div>
					</a>
				</div>
				<%-- Menu card for Speak --%>
				<div class="col-xs-12 col-sm-4">
					<a href="Speak.aspx">
						<div class="menu-card">
							<img src="Resources/Microphone-icon.png" alt="Pattern" />
							<h2>Speak</h2>
							<p class="menu-description">Test your M&#257;ori pronunciation skills and receive feedback</p>
						</div>
					</a>
				</div>
				<%-- Menu card for Scoreboard --%>
				<div class="col-xs-12 col-sm-4">
					<a href="Scoreboard.aspx">
						<div class="menu-card">
							<img src="Resources/Document-icon.png" alt="Pattern" />
							<h2>Scoreboard</h2>
							<p class="menu-description">Keep track of your pronunciation history and your score</p>
						</div>
					</a>
				</div>
			</div>
		</div>
	</section>

	<%-- The seond section contains a brief description of the MPAi project --%>
	<section id="section-2" class="padding-top padding-bottom">
		<div id="about-content" class="container outer">
			<h1>About MPAi</h1>
			<p>
				The importance of pronouncing Māori correctly is growing because of the increasing use and standing of Māori in ceremonial occasions in New Zealand. However unlike mainstream languages such as English, there are no existing pronunciation aids publicly available to provide feedback on the pronunciation of Māori. This project is developing a pronunciation aid providing feedback on spoken Māori vowels and words. The project draws its source materials from the MAONZE database, this unique database contains speech has over 60 hours of speech from 62 speakers of Māori (male and female). Māori, like many Indigenous languages, have speakers whose eloquence in the spoken language means that their speech is considered exemplars of the gold standard of that language and these speakers are typically older people. At least 40 of the speakers in the MOANZE database are considered to be gold standard, and we are therefore in the unique position to be able to develop our pronunciation aid, using as a reference point high quality exemplars.
			</p>
			<br/>
			<p>
				- Dr. Catherine Watson, Dr. Peter Keegan
			</p>
		</div>
	</section>

</asp:Content>
