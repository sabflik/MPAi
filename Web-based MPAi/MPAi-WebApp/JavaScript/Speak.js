//This script file is only referenced by the Speak.aspx file. It controls all behaviour of the Speak module
//and makes use of functions declared in the main.js file.
//Communicates with server via Play.aspx.cs class to retrieve recordings and Save.aspx.cs to analyse recording

//Initialise the recording as null
var blob = null;

//The Wavesurfer Player instance which is rendered within the #myAudio HTML audio element.
//It uses recorder.js to capture audio recordings.
var player = videojs("myAudio",
		{
		    controls: true,
		    width: 800,
		    height: 200,
		    plugins: {
		        wavesurfer: {
		            src: "live",
		            waveColor: "#000000",
		            progressColor: "#AB0F12",
		            debug: true,
		            cursorWidth: 1,
		            msDisplayMax: 20,
		            hideScrollbar: true
		        },
		        record: {
		            audio: true,
		            video: false,
		            maxLength: 20,
		            debug: true,
		            audioEngine: "recorder.js"
		        }
		    },
		    controlBar: {
		        fullscreenToggle: false
		    }
		});

//Find microphone after player is loaded
player.on('ready', function () {
    console.log('videojs is ready');
    player.recorder.getDevice();
});

//When an error is thrown by the player, log it on the web console
player.on('deviceError', function () {
    console.log('device error:', player.deviceErrorCode);
});
player.on('error', function (error) {
    console.log('error:', error);
});

//Log when recording has begun
player.on('startRecord', function () {
    console.log('started recording!');
});

//When recording has stopped, grab the recording blob and show the analyse button
player.on('finishRecord', function () {
    console.log('finished recording: ', player.recordedData);

    blob = player.recordedData;

    $('#analyse').show();
});

//Failed attempt at making the waveform within the media player responsive
//$(window).resize(function () {
//    player.wavesurfer.drawer.containerWidth = player.wavesurfer.drawer.container.clientWidth;
//    player.wavesurfer.drawBuffer();
//});

//Ensure that the collapsable elements aren't incorrectly toggled and store the initially selected category.
$('document').ready(function (e) {
    $('#record').collapse({ toggle: false });
    $('#searchErrorMessage').collapse({ toggle: false });
});

// Initialization
window.onbeforeunload = function () {
    document.getElementById(maoriWord.id).value = "";
};

//Validate word when 'enter' key is pressed on keyboard
$('#maoriWord').keypress(function (event) {
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
        validateWord();
        return false;
    }
});

//Initialise the expected word as null
var expectedWord = null;

//Validate word when 'search' button is clicked
$('#search').click(validateWord);

//Hide error messages as users are typing in the search bar
$('#maoriWord').on('input', function () {
    $('#searchErrorMessage').collapse('hide');
});

//This function is responsible for handling user input errors and only valid words are allowed to be recorded.
function validateWord() {
    //Empty the media player when a new word is searched and hide the preview button
    player.recorder.surfer.surfer.empty();

    $('#preview').hide();

    //If the user hasn't selected a word or submits only whitespace text, display an error message prompting the
    //user to type something. The section containing the media player and result text is hidden.
    if (wordIsEmpty()) {
        searchErrorMessage.innerText = "You must choose a Māori word";
        $('#searchErrorMessage').collapse('show');
        maoriWord.value = "";
        recordMessage.innerText = "";
        expectedWord = null;
        $('#record').collapse('hide');
        $('#analyse').hide();
        return;
    }

    //If users have entered a non-empty word, convert it to a word that would be recognised by the server.
    var wordName = getApprovedWord();

    //If the word cannot be mapped to any of the words available in the server database, then notify the user that
    //the entered word is not supported. The section containing the media player is hidden.
    if (wordName === "none") {
        searchErrorMessage.innerText = "Sorry, '" + maoriWord.value + "' is not recognised\nClick on the search bar to see a list of supported words";
        $('#searchErrorMessage').collapse('show');
        maoriWord.value = "";
        recordMessage.innerText = "";
        expectedWord = null;
        $('#record').collapse('hide');
        $('#analyse').hide();
        return;
    }

    //If submitted word is valid, hide all error messages and prompt user to record the word.
    $('#searchErrorMessage').collapse('hide');
    recordMessage.innerText = "Please record your pronounciation of the word '" + wordName + "' below";
    //Convert all spaces to underscores, as that's how the words are stored in the database.
    expectedWord = wordName.replace(/ /g, "_");

    //Load a preview audio file
    showPreview(expectedWord);

    $('#record').collapse('show');
    $('#analyse').hide();

    console.log("Target: " + expectedWord);
}

//This function loads the first available recording for a given word into a hidden preview media player
function showPreview(word) {
    var wordCategories = ["MODERN_FEMALE", "MODERN_MALE", "KUIA_FEMALE", "KAUMATUA_MALE"];

    //Loop through every category and find recordings of the chosen word for that category
    for (var category in wordCategories) {
        //Create a payload object containing the selected word name and category.
        var formData = new FormData();
        formData.append('wordName', word);
        formData.append('wordCategory', category);

        //If recording(s) are available for that category, load the first recording
        xhr('Play.aspx', formData, function (responseText) {
            if (responseText !== "nothing") {
                var previewPath = JSON.parse(responseText).resultJsonTable[0].path;
                previewMedia.src = previewPath;
                //Show the preview button
                $('#preview').show();
                return;
            }
        });
    }  
}

//Play the loaded recording when preview button is clicked
$("#preview").click(function () {
    previewMedia.play();
});

//Analyse the recording when analyse button is clicked and reset the state
$("#analyse").click(function () {
    if (blob) {
        analyse(blob);
    } else {
        console.log("Recording not found :(");

        showModal("white", ["<h4>Sorry, your recording was not found :(</h4>"]);
    }
    reset();
});

//Clear the recording so that users can't submit the same recording for analysis more than once
function reset() {
    $('#analyse').hide();
    blob = null;
}

//Send the recording to the server and register a callback function for the response
function analyse(blob) {
    console.log("Maori word: " + expectedWord);
    upload(blob, callBack);
}

//On receival of the response containing the word which the recording was analysed as, process the result
function callBack(response) {
    console.log("Response: " + response);
    
    //If bad response, notify the user using a modal popup, else process the result
    if (!response || response === "nothing") {
        showModal("white", ["<h4>Sorry, your pronunciation cannot be recognised</h4>"]);
    } else {
        var data = JSON.parse(response);
        if (data.result === "nothing") {
            showModal("white", ["<h4>Sorry, your pronunciation cannot be recognised</h4>"]);
        } else {
            processResult(data);
        }
    }
}

//Sort result into grade categories and customise score report depending on said category
function processResult(data) {
    //Grade categories and corresponding score report colours
    var categories = {
        BELOW_AVG: "red", ABOVE_AVG: "orange", EXCELLENT: "yellow", PERFECT: "green", UNDEFINED: "white"
    };

    var score = data.score;
    var result = data.result.replace(/_/g, ' ');
    var category;

    //Sort score into grade category
    if (score >= 0 && score < 50) {
        category = categories.BELOW_AVG;
    } else if (score >= 0 && score < 80) {
        category = categories.ABOVE_AVG;
    } else if (score >= 0 && score < 100) {
        category = categories.EXCELLENT;
    } else if (score === 100) {
        category = categories.PERFECT;
    } else {
        category = categories.UNDEFINED;
    }

    var bodyElements;

    //If uncategorisable or perfect score, set custom message
    if (category === categories.UNDEFINED) {
        bodyElements = ["<h4>Sorry, your pronunciation cannot be recognised</h4>"];
    } else if (category === categories.PERFECT) {
        var resultText = "<h2>Ka Pai!</h2>";
        var introText = "<h3>Your score is</h3>";
        var scoreText = "<h1>100%</h1>";

        bodyElements = [resultText, introText, scoreText];
        //Else set message to contain score and word which the recording was analysed as
    } else {
        var introText = "<h3>Your score is</h3>";
        var scoreText = "<h1>" + Math.floor(score) + "%</h1>";
        var resultText = "<h4>The word you pronounced is recognised as: \"" + result + "\"</h4>";

        bodyElements = [introText, scoreText, resultText];
    }
    //Display score report
    showModal(category, bodyElements);
}

//This function colours and displays custom message in the score report.
function showModal(colour, bodyElements) {
    //Clear previous elements from report
    $("#score-body").empty();
    //Append custom message elements to score report
    for (i = 0; i < bodyElements.length; i++) {
        console.log(bodyElements[i]);
        $("#score-body").append(bodyElements[i]);
    }

    $("#score-report").modal();
    //Set custom header colour of score report
    $("#score-header").css("background-color", colour);
}

//Upload audio file to server
function upload(blob, callBack) {
    var time = new Date().getTime().toString();
    var currentdate = new Date();
    var datetime = currentdate.getDate() + "-"
					+ (currentdate.getMonth() + 1) + "-"
					+ currentdate.getFullYear() + "@"
					+ currentdate.getHours() + "-"
					+ currentdate.getMinutes() + "-"
					+ currentdate.getSeconds() + "@";
    var fileName = datetime + time + '.wav';

    var formData = new FormData();
    formData.append('fileName', fileName);
    formData.append('blob', blob);
    formData.append('target', expectedWord);

    xhr('Save.aspx', formData, callBack);
}