$(function () {

    var words = [];

    // Create a new XMLHttpRequest.
    var request = new XMLHttpRequest();

    // Handle state changes for the request.
    request.onreadystatechange = function (response) {
        if (request.readyState === 4) {
            if (request.status === 200) {
                // Parse the JSON
                var jsonOptions = JSON.parse(request.responseText);

                $.each(jsonOptions.oldfemale, function (i, v) {
                    if ($.inArray(v.name, words) === -1) {
                        words.push(v.name);
                    }
                });

                $.each(jsonOptions.oldmale, function (i, v) {
                    if ($.inArray(v.name, words) === -1) {
                        words.push(v.name);
                    }
                });

                $.each(jsonOptions.youngmale, function (i, v) {
                    if ($.inArray(v.name, words) === -1) {
                        words.push(v.name);
                    }
                });

                $.each(jsonOptions.youngfemale, function (i, v) {
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
});