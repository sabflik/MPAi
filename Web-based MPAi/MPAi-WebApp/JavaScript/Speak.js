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
		    }
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


var words = [];

// Create a new XMLHttpRequest.
var request = new XMLHttpRequest();

// Handle state changes for the request.
request.onreadystatechange = function (response) {
    if (request.readyState === 4) {
        if (request.status === 200) {
            // Parse the JSON
            var jsonOptions = JSON.parse(request.responseText);

            $.each(jsonOptions.KUIA_FEMALE, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    words.push(v.name);
                }
            });

            $.each(jsonOptions.KAUMATUA_MALE, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    words.push(v.name);
                }
            });

            $.each(jsonOptions.MODERN_MALE, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    words.push(v.name);
                }
            });

            $.each(jsonOptions.MODERN_FEMALE, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    words.push(v.name);
                }
            });
        }
    }
};

// Set up and make the request.
request.open('GET', 'Dropdown.aspx', true);
request.send();

$('#maoriWord').autoComplete({
    minChars: 0,
    source: function (term, suggest) {
        term = term.toLowerCase();

        var suggestions = [];
        for (i = 0; i < words.length; i++)
            if (~(words[i]).toLowerCase().indexOf(term)) suggestions.push(words[i]);
        suggest(suggestions);
    },
    renderItem: function (item, search) {
        search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
        var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
        return '<div class="autocomplete-suggestion" data-word="' + item + '" data-val="' + search + '"> ' + item.replace(re, "<b>$1</b>") + '</div>';
    },
    onSelect: function (e, term, item) {
        $('#maoriWord').val(item.data('word'));
    }
});

// initialization
window.onbeforeunload = function () {
    document.getElementById(maoriWord.id).value = "";
};

var expectedWord = null;

// Button 'search' action
document.querySelector('#search').onclick = function () {
    if (!maoriWord.value || maoriWord.value.trim() === "") {
        message.innerText = "";
    } else if (words.indexOf(maoriWord.value) > -1) {
        message.innerText = "Expected word is: " + maoriWord.value;
        expectedWord = maoriWord.value;
    } else {
        message.innerText = "Sorry, that word is not currently supported";
    }
};

$("#analyse").click(function () {
    if (blob) {
        analyse(blob);
    } else {
        console.log("Recording not found :(");

        document.getElementById('result').innerText = "Sorry, your recording was not found :(";
        $("#score-report").modal();
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
        message.innerText = "";
        document.getElementById(maoriWord.id).focus();
        document.getElementById(maoriWord.id).select();
    } else {
        upload(blob, callBack);
    }
}

function callBack(response) {
    console.log("Response: " + response);
    
    if (response === "nothing" || !response) {
        document.getElementById('result').innerText = "Sorry, your pronunciation cannot be recognised.";
    } else {
        var data = JSON.parse(response);
        document.getElementById('score').innerText = "Your score is: " + data.score;
        document.getElementById('result').innerText = "Your pronunciation is recognised as: " + data.result;
    }
    
    $("#score-report").modal();
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