//Wavesurfer Player
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
var wordCategory;

$('document').ready(function (e) {
    $('#listen').collapse({ toggle: false });
    $('#recordings').collapse({ toggle: false });
    $('#searchErrorMessage').collapse({ toggle: false });

    wordCategory = $("input[name='category']:checked").val();
});

// Button 'search' action
$('#search').click(loadAudio);

$("input[name='category']").change(function () {
    var category = $("input[name='category']:checked").val();
    if (category) {
        wordCategory = category;
        loadAudio();
    }
});

$('#maoriWord').keypress(function (event) {
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
        loadAudio();
        return false;
    }
});

function loadAudio() {

    if (wordIsEmpty()) {
        searchErrorMessage.innerText = "You must choose a Māori word";
        $('#searchErrorMessage').collapse('show');
        maoriWord.value = "";
        $('#listen').collapse('hide');
        return;
    }

    var wordName = getApprovedWord().replace(/ /g, "_");

    if (wordName === "none") {
        searchErrorMessage.innerText = "Sorry, '" + maoriWord.value + "' is not recognised\nClick on the search bar to see a list of supported words";
        $('#searchErrorMessage').collapse('show');
        maoriWord.value = "";
        $('#listen').collapse('hide');
        return;
    }

    //var wordCategory = $('.active input').prop('value');
    //var wordCategory = $("input[name='category']:checked").val();

    console.log("Name: " + wordName);
    console.log("Category: " + wordCategory);

    var formData = new FormData();
    formData.append('wordName', wordName);
    formData.append('wordCategory', wordCategory);

    $('#searchErrorMessage').collapse('hide');

    xhr('Play.aspx', formData, function (responseText) {
        if (responseText === "nothing") {
            document.getElementById('result').innerText = "Sorry, there are no recordings for that category. Please select a different category.";
            $('#recordings').collapse('hide');
            $('#listen').collapse('show');
            $('#change').hide();
        } else {
            obj = JSON.parse(responseText);
            count = 0;
            document.getElementById("result").innerText = "Listening to " + (count + 1) + " of " + obj.resultJsonTable.length + " " + wordCategory.replace(/_/g, " ") + " speakers";
            $('#listen').collapse('show');
            $('#recordings').collapse('show');
            player.waveform.load(obj.resultJsonTable[0].path);

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

$('#maoriWord').on('input', function () {
    $('#searchErrorMessage').collapse('hide');
});

// Button 'change' action
$('#change').click(function () {
    count++;
    if (count >= obj.resultJsonTable.length) {
        count = 0;
    }
    player.waveform.load(obj.resultJsonTable[count].path);
    $('#listen').collapse('show');
    $('#recordings').collapse('show');
});