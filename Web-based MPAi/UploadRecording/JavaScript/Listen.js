var player = videojs("myAudio",
		{
		    controls: true,
		    width: 800,
		    height: 200,
		    plugins: {
		        wavesurfer: {
		            waveColor: "#588efb",
		            progressColor: "#f043a4",
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




var obj;
var count = 0;

// Button 'search' action
document.querySelector('#search').onclick = function () {
    var wordName = maoriWord.value;
    var wordCategory = category.value;

    var formData = new FormData();
    formData.append('wordName', wordName);
    formData.append('wordCategory', wordCategory);

    xhr('Play.aspx', formData, function (responseText) {
        if (responseText == "nothing") {
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
        if (request.readyState == 4 && request.status == 200) {
            callback(request.responseText);
        }
    };
    request.open('POST', url);
    request.send(formData);
}


//// Get the <datalist> and <input> elements.
//var dataList = document.getElementById('json-datalist');
//var input = document.getElementById('ajax');

//// Create a new XMLHttpRequest.
//var request = new XMLHttpRequest();

//// Handle state changes for the request.
//request.onreadystatechange = function (response) {
//    if (request.readyState === 4) {
//        if (request.status === 200) {
//            // Parse the JSON
//            var jsonOptions = JSON.parse(request.responseText);

//            // Loop over the JSON array.
//            jsonOptions.forEach(function (item) {
//                // Create a new <option> element.
//                var option = document.createElement('option');
//                // Set the value using the item in the JSON array.
//                option.value = item;
//                // Add the <option> element to the <datalist>.
//                dataList.appendChild(option);
//            });

//            // Update the placeholder text.
//            input.placeholder = "Search...";
//        } else {
//            // An error occured :(
//            input.placeholder = "Couldn't load datalist options :(";
//        }
//    }
//};

//// Update the placeholder text.
//input.placeholder = "Loading options...";

//// Set up and make the request.
//request.open('GET', 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/html-elements.json', true);
//request.send();