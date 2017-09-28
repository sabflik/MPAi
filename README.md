# MPAi: A Web-based Maori Pronunciation Application

## Summary
This application can be used improve one's pronunciation of the Maori language, and currently supports 85 different words or phrases. It contains a dataset of recordings from historical and modern Maori speakers, which users can listen to and makes use of a speech recognition system to analyse the pronunciation of user recordings. This website can be accessed at [https://mpai-speak.uoa.auckland.ac.nz](https://mpai-speak.uoa.auckland.ac.nz) from within the University of Auckland network. It is compatible with Google Chrome, Mozilla Firefox, and Opera, and can be accessed from any desktop or Android smart device. 

## Editing the server
* The application is hosted on a web server within the University of Auckland. It can be accessed via Remote Desktop Connection at the same address as the website. 
* Changes to the server side code need to be compiled on a local machine using Visual Studio, and moved onto the web server in order to take effect; the server can only run compiled code. Changes to the HTML, CSS, and Javascript can be done without this step.
* Retraining the data model used to recognise speech must be done through the scripts in the HTK/Batches folder, and changes will occur immediately.
* This application was built using a variety of different application frameworks, allowing for greater functionality.
* Further details on these topics, as well as a graphic summarising the most recent version of this application, can be found on [the wiki.](https://github.com/sabflik/MPAi/wiki)
