# Application SetUp
## Prerequisites
The following programs must be installed on your local machine:
* Remote Desktop Connection
* Microsoft Visual Studio
* A VPN Service e.g. Cisco AnyConnect Secure Mobility Client (Optional)

## Accessing the Server
1. You must first be connected to the University of Auckland network. This can be done by directly connecting to the network or through a VPN service. 
2. Open up Window's Remote Desktop Connection and enter mpai-speak.uoa.auckland.ac.nz into the 'Computer' field.
3. Enter your University credentials, with username in the following format: UOA\\{upi}.

## Deploying the Website
Once cloned from Github, the application must be compiled by running it through Microsoft Visual Studio. Launching the website for the first time will take a while, as all the back-end code is compiled and databases are built. A /bin folder containing all the compiled C# code will be generated and the database files inside /App_Data folder as well as MPAiDb.sqlite are created. All files excluding the /obj folder must be copied over to the C:\Users\Public\Documents\Updated MPAi directory on the server (This path can be changed through the IIS8 manager by clicking MPAi under 'Sites' and changing the physical path under 'Basic Settings...' as well as under 'View Virtual Directories'). The website should then be live!

## Changes to the Speech Recogniser
Changes to files within the /HTK folder can be done directly on the server. Since the application starts the reognition process through the HTKEngine.cs class, changes made to this requires compilation for changes to take effect. Adding or removing audio files from the training dataset will cause the database to be inconsistent with the speech recogniser, therefore, all databases (files inside /App_Data and MPAiDb.sqlite) must be deleted. Once the databases are deleted, opening the website again will automatically re-build the databases with the updated audio files.

# Future Work
* Improve the accuracy of the speech recognition system, for example, by filtering out background noise and accounting for silences on either end of the word.
* Support for Apple devices.
* Expand analysis to test pronunciation for entire sentences instead of simple words and phrases.
* Introduce more gamification elements such as user levels or spendable points.
* Add other features from [MPAi](https://github.com/ciwatson/MPAi)
* SSL certificate is currently self-signed.
* Improve security of application to allow access to server from outside the Univeristy network.
* [Known Issues](https://github.com/sabflik/MPAi/issues).
