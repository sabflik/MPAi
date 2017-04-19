<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="UploadRecording.index" %>

<!DOCTYPE html>

<html lang="en">

    <head runat="server">
        <title>MPAi-Speak</title>

        <script src="https://cdn.WebRTC-Experiment.com/MediaStreamRecorder.js"></script>
        <%--<script src="JavaScript/OldMediaStreamRecorder.js"></script>--%>

        <!-- for Edige/FF/Chrome/Opera/etc. getUserMedia support -->

        <script src="https://cdn.WebRTC-Experiment.com/gumadapter.js"></script>

        <style>
            input {
                border: 1px solid rgb(49, 79, 79);
                border-radius: 3px;
                font-size: 1em;
                width: 100px;
                text-align: center;
            }

            button {
                border: 1px solid rgb(49, 79, 79);
                border-radius: 3px;
                vertical-align: middle;
                height: auto;
                font-size: inherit;
            }

            ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                overflow: hidden;
                background-color: #333;
            }

            li {
                float: left;
            }

            li a {
                display: block;
                color: white;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }

            li a:hover {
                background-color: #111;
            }
        </style>
    </head>

    <body>

        <div style="margin:0 auto; width:500px; height:100px;">
            
            <section class="experiment" style="padding: 5px;">
                <ul>
                    <li><a class="active" href="index.aspx">Speak</a></li>
                    <li><a class="active" href="Listen.aspx">Listen</a></li>
                </ul>
                <br />
                <label for="maoriWord">Your Maori word to pronounce:</label>
                <input type="text" id="maoriWord"/>
                <label id="alertWord" style="color:red"></label>
                <br />
                <label style="color:purple">Please double the vowels to show long vowels.</label>
                <br />
                <br />
                <button id="start-recording">Record</button>
                <button id="stop-recording" disabled>Stop</button>
                <button id="analyse-recording" disabled>Analyse</button>
                <button id="save-recording" disabled>Download</button>
            </section>

            <section class="experiment" style="padding: 5px;">
                <div id="audios-container"></div>
                <audio id="recording"></audio>
                <label id ="edgeNotice" style ="color:green;"></label>
            </section>
            <section class="experiment" style="padding: 5px;">
                <div id="result" style="color:purple"></div>
            </section>
            <script>
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

                document.querySelector('#start-recording').onclick = function () {
                    this.disabled = true;
                    document.querySelector('#stop-recording').disabled = false;
                    document.querySelector('#save-recording').disabled = true;
                    document.querySelector('#analyse-recording').disabled = true;
                    document.querySelector('#save-recording').textContent = "Download";
                    audiosContainer.innerHTML = "";
                    currentBlob = null;
                    edgeNotice.innerText = "";
                    result.innerText = "";
                    captureUserMedia(mediaConstraints, onMediaSuccess, onMediaError);
                };

                document.querySelector('#stop-recording').onclick = function () {
                    this.disabled = true;
                    mediaRecorder.stop();
                    if (!IsChrome) {
                        mediaRecorder.stream.stop();
                    }
                    document.querySelector('#start-recording').disabled = false;
                    document.querySelector('#save-recording').disabled = false;
                    document.querySelector('#analyse-recording').disabled = false;
                    // delete auio player on Edge
                    if (IsEdge) {
                        audiosContainer.remove(recordingPlayer);
                        edgeNotice.innerText = "Successfully recorded!";
                    }
                };

                document.querySelector('#save-recording').onclick = function () {
                    mediaRecorder.save();
                };

                document.querySelector('#analyse-recording').onclick = function () {
                    this.disabled = true;
                    analyse(currentBlob);
                };

                document.querySelector('#maoriWord').oninput = function () {
                    alertWord.innerText = "";
                    if (audiosContainer.innerHTML != "" && document.querySelector("#stop-recording").disabled == true) {
                        document.querySelector('#analyse-recording').disabled = false;
                    }
                }

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
                        document.querySelector("#save-recording").textContent = "Download (" + bytesToSize(blob.size) + ")";
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
                        if (secondStamp == currentSecondStamp && timeStamp != currentTimeStamp) {
                            a.parentNode.removeChild(a);
                        }

                        // Save to currentBlob
                        if (currentBlob == null) {
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
                    document.querySelector('#start-recording').disabled = false;
                    document.querySelector('#stop-recording').disabled = true;
                    document.querySelector('#save-recording').disabled = true;
                    document.querySelector('#analyse-recording').disabled = true;
                    document.getElementById(maoriWord.id).value = "";
                };

                // analyse function
                function analyse(blob) {
                    if (maoriWord.value == "") {
                        document.getElementById(alertWord.id).innerText = "Please input your word!";
                        document.getElementById(maoriWord.id).focus();
                        document.getElementById(maoriWord.id).select();
                    } else {
                        upload(blob, callBack);
                        function callBack(data) {
                            if (data == "nothing") {
                                document.getElementById('result').innerHTML = "Sorry, your pronunciation cannot be recognised.";
                            } else {
                                document.getElementById('result').innerHTML = "Your pronunciation is recognised as: " + data;
                            }
                        }
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
                        if (request.readyState == 4 && request.status == 200) {
                            callback(request.responseText);
                        }
                    };
                    request.open('POST', url);
                    request.send(formData);
                }
            </script>
        </div>
    </body>
</html>