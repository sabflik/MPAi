var player = videojs("myAudio",
		{
			controls: true,
			width: 800,
			height: 200,
			plugins: {
				wavesurfer: {
					src: "live",
					waveColor: "#588efb",
					progressColor: "#f043a4",
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

	var blob = player.recordedData;

	//document.querySelector('#analyse-recording').disabled = false;
	analyse(blob);
});




// declare variables
var mediaConstraints = {
	audio: true
};
var mediaRecorder;
var currentBlob;
var audiosContainer = document.getElementById('audios-container');
var currentTimeStamp;
var currentSecondStamp;
var recordingPlayer;

function captureUserMedia(mediaConstraints, successCallback, errorCallback) {
	navigator.mediaDevices.getUserMedia(mediaConstraints).then(successCallback).catch(errorCallback);
}

//document.querySelector('#start-recording').onclick = function () {
//	this.disabled = true;
//	document.querySelector('#stop-recording').disabled = false;
//	document.querySelector('#save-recording').disabled = true;
//	document.querySelector('#analyse-recording').disabled = true;
//	document.querySelector('#save-recording').textContent = "Download";
//	audiosContainer.innerHTML = "";
//	currentBlob = null;
//	edgeNotice.innerText = "";
//	result.innerText = "";
//	captureUserMedia(mediaConstraints, onMediaSuccess, onMediaError);
//};

//document.querySelector('#stop-recording').onclick = function () {
//	this.disabled = true;
//	mediaRecorder.stop();
//	if (!IsChrome) {
//		mediaRecorder.stream.stop();
//	}
//	document.querySelector('#start-recording').disabled = false;
//	document.querySelector('#save-recording').disabled = false;
//	document.querySelector('#analyse-recording').disabled = false;
//	// delete auio player on Edge
//	if (IsEdge) {
//		audiosContainer.remove(recordingPlayer);
//		edgeNotice.innerText = "Successfully recorded!";
//	}
//};

//document.querySelector('#save-recording').onclick = function () {
//	mediaRecorder.save();
//};

//document.querySelector('#analyse-recording').onclick = function () {
//	this.disabled = true;
//	analyse(currentBlob);
//};

document.querySelector('#maoriWord').oninput = function () {
	alertWord.innerText = "";
	//if (audiosContainer.innerHTML !== "" && document.querySelector("#stop-recording").disabled === true) {
	//	document.querySelector('#analyse-recording').disabled = false;
	//}
};

// Record audio
function onMediaSuccess(stream) {
	var audio = document.createElement('audio');
	audio = mergeProps(audio, {
		controls: false,
		muted: true,
		src: URL.createObjectURL(stream)
	});
	audio.play();
	audiosContainer.appendChild(audio);

	mediaRecorder = new MediaStreamRecorder(stream);
	mediaRecorder.stream = stream;
	mediaRecorder.mimeType = 'audio/wav';
	mediaRecorder.audioChannels = 1;
	mediaRecorder.ondataavailable = function (blob) {
		var timeStamp = new Date().getTime().toString();
		var currentdate = new Date();
		var secondStamp = currentdate.getDate() + "-"
					+ (currentdate.getMonth() + 1) + "-"
					+ currentdate.getFullYear() + "@"
					+ currentdate.getHours() + "-"
					+ currentdate.getMinutes() + "-"
					+ currentdate.getSeconds();

		// Amend dowload button text
		//document.querySelector("#save-recording").textContent = "Download (" + bytesToSize(blob.size) + ")";
		// Add a player to play the recording
		recordingPlayer = document.createElement('audio');
		recordingPlayer = mergeProps(audio, {
			controls: true,
			muted: false,
			src: URL.createObjectURL(blob)
		});
		//recordingPlayer.play();
		audiosContainer.appendChild(recordingPlayer);

		// delete the extra link
		if (secondStamp === currentSecondStamp && timeStamp !== currentTimeStamp) {
			a.parentNode.removeChild(a);
		}

		// Save to currentBlob
		if (currentBlob === null) {
			// Firefox produces two blobs with the second one invalid
			currentBlob = blob;
			currentTimeStamp = timeStamp;
			currentSecondStamp = secondStamp;
		} else {
			blob = null;
		}
	};

	// get another blob after 30 seconds
	var timeInterval = 30 * 1000;
	mediaRecorder.start(timeInterval);
}

function onMediaError(e) {
	console.error('media error', e);
}

// below function via: http://goo.gl/B3ae8c
function bytesToSize(bytes) {
	var k = 1024;
	var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
	if (bytes === 0) return '0 Bytes';
	var i = parseInt(Math.floor(Math.log(bytes) / Math.log(k)), 10);
	return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
}

// initialization
window.onbeforeunload = function () {
	//document.querySelector('#start-recording').disabled = false;
	//document.querySelector('#stop-recording').disabled = true;
	//document.querySelector('#save-recording').disabled = true;
	//document.querySelector('#analyse-recording').disabled = true;
	document.getElementById(maoriWord.id).value = "";
};

// analyse function
function analyse(blob) {
	console.log("Maori word: "+maoriWord.value);
	if (maoriWord.value === "") {
		document.getElementById(alertWord.id).innerText = "Please input your word!";
		document.getElementById(maoriWord.id).focus();
		document.getElementById(maoriWord.id).select();
	} else {
		upload(blob, callBack);
	}
}

function callBack(data) {
	console.log("Data: " + data);
	if (data === "nothing") {
		document.getElementById('result').innerHTML = "Sorry, your pronunciation cannot be recognised.";
	} else {
		document.getElementById('result').innerHTML = "Your pronunciation is recognised as: " + data;
	}
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