var blob = null;

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

player.on('ready', function () {
    console.log('videojs is ready');
    player.recorder.getDevice();
});

// error handling
player.on('deviceError', function () {
    console.log('device error:', player.deviceErrorCode);
});
player.on('error', function (error) {
    console.log('error:', error);
});

// user clicked the record button and started recording
player.on('startRecord', function () {
    console.log('started recording!');
});

// user completed recording and stream is available
player.on('finishRecord', function () {
    // the blob object contains the recorded data that
    // can be downloaded by the user, stored on server etc.
    console.log('finished recording: ', player.recordedData);

    blob = player.recordedData;

    document.querySelector('#analyse').disabled = false;
});

//$(window).resize(function () {
//    player.wavesurfer.drawer.containerWidth = player.wavesurfer.drawer.container.clientWidth;
//    player.wavesurfer.drawBuffer();
//});

$('document').ready(function (e) {
    $('#record').collapse({ toggle: false });
});

var words = [];

// Create a new XMLHttpRequest.
var request = new XMLHttpRequest();

// Handle state changes for the request.
request.onreadystatechange = function (response) {
    if (request.readyState === 4) {
        if (request.status === 200) {
            // Parse the JSON
            words = JSON.parse(request.responseText);
        }
    }
};

// Set up and make the request.
request.open('GET', 'Dropdown.aspx', true);
request.send();

// initialization
window.onbeforeunload = function () {
    document.getElementById(maoriWord.id).value = "";
};

$('#maoriWord').keypress(function (event) {
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
        getTarget();
        maoriWord.value = "";
        return false;
    }
});

var expectedWord = null;

// Button 'search' action
document.querySelector('#search').onclick = function () {
    getTarget();
    maoriWord.value = "";
};

document.querySelector('#maoriWord').oninput = function () {
    searchErrorMessage.innerText = "";
};

function getTarget() {
    if (!maoriWord.value || maoriWord.value.trim() === "") {
        searchErrorMessage.innerText = "You must choose a M\u0101ori word";
        recordMessage.innerText = "";
        expectedWord = null;
        $('#record').collapse('hide');
    } else {
        var target = maoriWord.value.toLowerCase();

        if (words.indexOf(target) > -1) {
            searchErrorMessage.innerText = "";
            recordMessage.innerText = "Please record your pronounciation of the word '" + target+"' below";
            expectedWord = target.replace(/ /g, "_");
            $('#record').collapse('show');
        } else {
            searchErrorMessage.innerText = "Sorry, '"+maoriWord.value+"' is not recognised\nClick on the search bar to see a list of supported words";
            recordMessage.innerText = "";
            expectedWord = null;
            $('#record').collapse('hide');
        }
    }
    console.log("Target: " + expectedWord);
}

$("#analyse").click(function () {
    if (blob) {
        analyse(blob);
    } else {
        console.log("Recording not found :(");

        showModal("white", ["<h4>Sorry, your recording was not found :(</h4>"]);
    }
    reset();
});

function reset() {
    document.querySelector('#analyse').disabled = true;
    blob = null;
}

// analyse function
function analyse(blob) {
    console.log("Maori word: " + expectedWord);
    if (!expectedWord || expectedWord.trim() === "") {
        recordMessage.innerText = "";
        document.getElementById(maoriWord.id).focus();
        document.getElementById(maoriWord.id).select();
    } else {
        upload(blob, callBack);
    }
}

function callBack(response) {
    console.log("Response: " + response);
    
    if (response === "nothing" || !response) {
        showModal("white", ["<h4>Sorry, your pronunciation cannot be recognised</h4>"]);
    } else {
        var data = JSON.parse(response);
        processResult(data);
    }
}

function processResult(data) {
    var categories = {
        BELOW_AVG: "red", ABOVE_AVG: "orange", EXCELLENT: "yellow", PERFECT: "green", UNDEFINED: "white"
    };

    var score = data.score;
    var result = data.result;
    var category;

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

    if (category === categories.UNDEFINED) {
        bodyElements = ["<h4>Sorry, your pronunciation cannot be recognised</h4>"];
    } else if (category === categories.PERFECT) {
        var introText = "<h3>Your score is</h3>";
        var scoreText = "<h1>"+ score+"</h1>";
        var resultText = "<h4>Ka Pai!</h4>";

        bodyElements = [introText, scoreText, resultText];
    } else {
        var introText = "<h3>Your score is</h3>";
        var scoreText = "<h1>" + score + "</h1>";
        var resultText = "<h4>Your pronunciation is recognised as: " + result+"</h4>";

        bodyElements = [introText, scoreText, resultText];
    }
    
    showModal(category, bodyElements);
}

function showModal(colour, bodyElements) {

    $("#score-body").empty();
    for (i = 0; i < bodyElements.length; i++) {
        console.log(bodyElements[i]);
        $("#score-body").append(bodyElements[i]);
    }

    $("#score-report").modal();
    $("#score-header").css("background-color", colour);
}

// upload audio file to server
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

function xhr(url, formData, callback) {
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === 4 && request.status === 200) {
            callback(request.responseText);
        }
    };
    request.open('POST', url);
    request.send(formData);
}