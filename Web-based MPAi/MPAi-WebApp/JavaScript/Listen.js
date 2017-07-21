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
    loadAudio();
};

$("input[name='category']").change(function () {
    loadAudio();
});

function loadAudio() {
    var wordName = maoriWord.value.toLowerCase();
    var wordCategory = $("input[name='category']:checked").val();

    console.log("Name: " + wordName);
    console.log("Category: " + wordCategory);

    var formData = new FormData();
    formData.append('wordName', wordName);
    formData.append('wordCategory', wordCategory);

    if (!wordName || wordName.trim() === "") {
        document.getElementById('result').innerText = "";
    } else {
        xhr('Play.aspx', formData, function (responseText) {
            if (responseText === "nothing") {
                document.getElementById('result').innerText = "Sorry, that combination of word and category is not currently supported";
                document.querySelector('#change').disabled = true;
            } else {
                obj = JSON.parse(responseText);
                count = 0;
                document.getElementById("result").innerText = "Listening to " + (count + 1) + " of " + obj.resultJsonTable.length + " available speakers";
                player.waveform.load(obj.resultJsonTable[0].path);

                if (obj.resultJsonTable.length > 1) {
                    document.querySelector('#change').disabled = false;
                }
            }
        });
    }


}

// Button 'change' action
document.querySelector('#change').onclick = function () {
    count++;
    if (count >= obj.resultJsonTable.length) {
        count = 0;
    }
    player.waveform.load(obj.resultJsonTable[count].path);
    document.getElementById("result").innerText = "Listening to " + (count + 1) + " of " + obj.resultJsonTable.length + " available speakers";
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