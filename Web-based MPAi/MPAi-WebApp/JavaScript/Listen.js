//This script file is only referenced by the Listen.aspx file. It controls all behaviour of the Listen module
//and makes use of functions declared in the main.js file.
//Communicates with server via Play.aspx.cs class to retrieve recordings

//The Wavesurfer Player instance which is rendered within the #myAudio HTML audio element.
var player = videojs("myAudio",
		{
		    controls: true,
		    width: 800,
		    height: 200,
		    plugins: {
		        wavesurfer: {
		            waveColor: "#000000",
		            progressColor: "#AB0F12",
		            debug: true,
		            cursorWidth: 1,
		            msDisplayMax: 20,
		            hideScrollbar: true
		        }
		    },
		    controlBar: {
		        fullscreenToggle: false
		    }
		});

//When an error is thrown by the player, log it on the web console
player.on('error', function (error) {
    console.log('error:', error);
});

//Failed attempt at making the waveform within the media player responsive
//$(window).resize(function () {
//    player.wavesurfer.drawer.containerWidth = player.width;
//    player.wavesurfer.drawBuffer();
//});

var obj;
var count = 0;
var wordCategory;

//Ensure that the collapsable elements aren't incorrectly toggled and store the initially selected category.
//This should be modern female, as declared on the Listen.aspx page.
$('document').ready(function (e) {
    $('#listen').collapse({ toggle: false });
    $('#recordings').collapse({ toggle: false });
    $('#searchErrorMessage').collapse({ toggle: false });

    wordCategory = $("input[name='category']:checked").val();
});

//Validate word when 'search' button is clicked
$('#search').click(validateWord);

//Validate word when the category selection changes
$("input[name='category']").change(function () {
    var category = $("input[name='category']:checked").val();
    //This 'if' statement is needed because a library bug causes data-toggle="buttons" elements to be unchecked
    //despite bring declared as radio buttons.
    if (category) {
        wordCategory = category;
        validateWord();
    }
});

//Validate word when 'enter' key is pressed on keyboard
$('#maoriWord').keypress(function (event) {
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
        validateWord();
        return false;
    }
});

//This function is responsible for handling user input errors and recordings are only queried for valid words.
function validateWord() {

    //If the user hasn't selected a word or submits only whitespace text, display an error message prompting the
    //user to type something. The section containing the media player and result text is hidden.
    if (wordIsEmpty()) {
        searchErrorMessage.innerText = "You must choose a Māori word";
        $('#searchErrorMessage').collapse('show');
        maoriWord.value = "";
        $('#listen').collapse('hide');
        return;
    }

    //If users have entered a non-empty word, convert it to a word that would be recognised by the server.
    //Convert all spaces to underscores, as that's how the words are stored in the database.
    var wordName = getApprovedWord().replace(/ /g, "_");

    //If the word cannot be mapped to any of the words available in the server database, then notify the user that
    //the entered word is not supported. The section containing the media player and result text is hidden.
    if (wordName === "none") {
        searchErrorMessage.innerText = "Sorry, '" + maoriWord.value + "' is not recognised\nClick on the search bar to see a list of supported words";
        $('#searchErrorMessage').collapse('show');
        maoriWord.value = "";
        $('#listen').collapse('hide');
        return;
    }

    //If submitted word is valid, hide all error messages and find recordings for the word and category combination.
    $('#searchErrorMessage').collapse('hide');
    findRecordings(wordName);
}

//This function is responsible for sending the selected word and category to the server and handling the response.
function findRecordings(wordName) {

    //For debugging purposes, print values to the web console.
    console.log("Name: " + wordName);
    console.log("Category: " + wordCategory);

    //Create a payload object containing the selected word name and category.
    var formData = new FormData();
    formData.append('wordName', wordName);
    formData.append('wordCategory', wordCategory);

    //Send a request to the server to find recordings for the word and category specified in the payload.
    //The server response is then processed.
    xhr('Play.aspx', formData, function (responseText) {

        //If the server couldn't find any recordings for that word and category, let the user know so through the result text.
        //Hide the media player and change recording button.
        if (responseText === "nothing") {
            document.getElementById('result').innerText = "Sorry, there are no recordings for that category. Please select a different category.";
            $('#recordings').collapse('hide');
            $('#listen').collapse('show');
            $('#change').hide();
            //If at least one recording is available...
        } else {
            obj = JSON.parse(responseText);
            count = 0;

            //...show the media player, load the first recording into the player,...
            $('#listen').collapse('show');
            $('#recordings').collapse('show');
            player.waveform.load(obj.resultJsonTable[0].path);

            //...and if there is more than one recording, show the change recording button
            if (obj.resultJsonTable.length > 1) {
                if (wordCategory === "KAUMATUA_MALE") {
                    document.getElementById("result").innerText = " to try a different KAUMĀTUA MALE pronounciation";
                } else {
                    document.getElementById("result").innerText = " to try a different " + wordCategory.replace(/_/g, " ") + " pronounciation";
                }
                $('#change').show();
            } else {
                document.getElementById("result").innerText = "";
                $('#change').hide();
            }
        }
    });
}

//Hide error messages as users are typing in the search bar
$('#maoriWord').on('input', function () {
    $('#searchErrorMessage').collapse('hide');
});

//When change recording button is clicked, load the next recording into the player.
//Loop back to the first recording when the end of the list is reached.
$('#change').click(function () {
    count++;
    if (count >= obj.resultJsonTable.length) {
        count = 0;
    }
    player.waveform.load(obj.resultJsonTable[count].path);
    $('#listen').collapse('show');
    $('#recordings').collapse('show');
});