var words = [];
var wordsWithoutMacron = [];

// Create a new XMLHttpRequest.
var request = new XMLHttpRequest();

// Handle state changes for the request.
request.onreadystatechange = function (response) {
    if (request.readyState === 4) {
        if (request.status === 200) {
            // Parse the JSON
            words = JSON.parse(request.responseText);

            for (var i = 0; i < words.length; i++) {
                wordsWithoutMacron.push(replaceDiacritics(words[i]));
            }
            populateDropdown()
        }
    }
};

// Set up and make the request.
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

function populateDropdown() {
    $('#maoriWord').attr('placeholder', 'Search...');
    $('#maoriWord').attr('disabled', false);

    console.log(wordsWithoutMacron);

    $('#maoriWord').autoComplete({
        minChars: 0,
        source: function (term, suggest) {
            term = term.toLowerCase();

            var suggestions = [];
            for (i = 0; i < words.length; i++)
                if (~(words[i]).toLowerCase().indexOf(term) || ~(wordsWithoutMacron[i]).toLowerCase().indexOf(term)) suggestions.push(words[i]);
            suggest(suggestions);
        },
        renderItem: function (item, search) {
            search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
            var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
            return '<div class="autocomplete-suggestion" data-word="' + item + '" data-val="' + search + '"> ' + item.replace(re, "<b>$1</b>") + '</div>';
        },
        onSelect: function (e, term, item) {
            $('#maoriWord').val(item.data('word'));
            $('#search').click();
        }
    });
}

function wordIsEmpty() {
    return (!maoriWord.value || maoriWord.value.trim() === "");
}

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