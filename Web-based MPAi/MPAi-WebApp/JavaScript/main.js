//This script file is referenced by the Listen.aspx, Speak.aspx, and Scoreboard.aspx.
//It contains functions that are common to all modules.
//Communicates with server via Dropdown.aspx.cs class to retrieve list of all supported words

var words = [];//List of all supported words with macrons
var wordsWithoutMacron = [];//List of all supported words without macrons

// Create a new XMLHttpRequest.
var request = new XMLHttpRequest();

//When server responds with list of supported words, store these words in an array
request.onreadystatechange = function (response) {
    if (request.readyState === 4) {
        if (request.status === 200) {
            // Parse the JSON and store words
            words = JSON.parse(request.responseText);
            //Also store a list of the words with all the macrons stripped.
            for (var i = 0; i < words.length; i++) {
                wordsWithoutMacron.push(replaceDiacritics(words[i]));
            }
            //Populate the search bar dropdown with the supported words
            populateDropdown()
        }
    }
};

//Retrieve list of all supported words from server
request.open('GET', 'Dropdown.aspx', true);
request.send();

//Code for replacing diacritrics from: https://stackoverflow.com/questions/863800/replacing-diacritics-in-javascript
function replaceDiacritics(s) {

    var diacritics = [
        /[\300-\306]/g, /[\340-\346]/g,  // A, a
        /[\310-\313]/g, /[\350-\353]/g,  // E, e
        /[\314-\317]/g, /[\354-\357]/g,  // I, i
        /[\322-\330]/g, /[\362-\370]/g,  // O, o
        /[\331-\334]/g, /[\371-\374]/g,  // U, u
        /[\321]/g, /[\361]/g, // N, n
        /[\307]/g, /[\347]/g, // C, c
    ];

    var chars = ['A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u', 'N', 'n', 'C', 'c'];

    for (var i = 0; i < diacritics.length; i++) {
        s = s.replace(diacritics[i], chars[i]);
    }

    return s;
}

//This function populates the Maori word search bar with a list of all supported words.
//
function populateDropdown() {
    //Once words are loaded, change placeholder text from "Loading..." to "Search..." and enable input
    $('#maoriWord').attr('placeholder', 'Search...');
    $('#maoriWord').attr('disabled', false);

    console.log(wordsWithoutMacron);

    $('#maoriWord').autoComplete({
        minChars: 0,
        //This function is used for filtering words based on what the user has typed
        source: function (term, suggest) {
            term = term.toLowerCase();//Make comparison case insensitive

            var suggestions = [];
            for (i = 0; i < words.length; i++)
                //If the any of the supported words contain a substring of the typed word, add that word to the suggestions.
                //Compare word to both macron and non-macron lists, to ensure that users who can't type macron characters can
                //still have that word understood. E.g. When user types mao, the word "Māori" should be suggested.
                if (~(words[i]).toLowerCase().indexOf(term) || ~(wordsWithoutMacron[i]).toLowerCase().indexOf(term)) suggestions.push(words[i]);
            suggest(suggestions);
        },
        //This funtion is used to render the suggested words in the list.
        renderItem: function (item, search) {
            search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
            var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
            return '<div class="autocomplete-suggestion" data-word="' + item + '" data-val="' + search + '"> ' + item.replace(re, "<b>$1</b>") + '</div>';
        },
        //This function is called when a suggested word from the dropdown is clicked.
        onSelect: function (e, term, item) {
            //Word is loaded into the search bar and search functionality is automatically executed
            $('#maoriWord').val(item.data('word'));
            $('#search').click();
        }
    });
}

//Determines if the word in the search bar is empty or only contains whitespace chars
function wordIsEmpty() {
    return (!maoriWord.value || maoriWord.value.trim() === "");
}

//Checks if the word in the search bar is found in the list of supported words.
//Checks both macron and non-macron lists but returns macron word as the server only recognises the macron form.
//E.g. if user types maori, it will be identified as a valid word in the non-macron list, and the word "Māori" will
//be sent to query the server.
function getApprovedWord() {
    var index = Math.max(words.indexOf(maoriWord.value.toLowerCase()), wordsWithoutMacron.indexOf(maoriWord.value.toLowerCase()));
    return (index > -1) ? words[index] : "none";
}

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