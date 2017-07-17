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
		    }
		});

// error handling
player.on('error', function (error) {
    console.log('error:', error);
});

//$(window).resize(function () {
//    player.wavesurfer.drawer.containerWidth = player.width;
//    player.wavesurfer.drawBuffer();
//});


var obj;
var count = 0;

// Button 'search' action
document.querySelector('#search').onclick = function () {
    var wordName = maoriWord.value;
    var wordCategory = category.value;

    console.log("Name: " + wordName);
    console.log("Category: " + wordCategory);

    var formData = new FormData();
    formData.append('wordName', wordName);
    formData.append('wordCategory', wordCategory);

    xhr('Play.aspx', formData, function (responseText) {
        if (responseText === "nothing") {
            document.getElementById('result').innerHTML = "Sorry, the word cannot be found.";
        } else {
            obj = JSON.parse(responseText);
            count = 0;
            document.getElementById("result").innerHTML = +obj.resultJsonTable.length + " different pronunciations available, and this is No." + (count + 1);
            player.waveform.load(obj.resultJsonTable[0].path);
        }
    });
};

// Button 'change' action
document.querySelector('#change').onclick = function () {
    count++;
    if (count >= obj.resultJsonTable.length) {
        count = 0;
    }
    player.waveform.load(obj.resultJsonTable[count].path);
    document.getElementById("result").innerHTML = obj.resultJsonTable.length + " different pronunciations available, and this is No." + (count + 1);
};

// xhr fuction
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