$(function () {

    // Create a new XMLHttpRequest.
    var request = new XMLHttpRequest();

    // Handle state changes for the request.
    request.onreadystatechange = function (response) {
        if (request.readyState === 4) {
            if (request.status === 200) {
                // Parse the JSON
                var words = JSON.parse(request.responseText);

                $('#maoriWord').attr('placeholder', 'Search...');
                $('#maoriWord').attr('disabled', false);

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
                        $('#search').click();
                    }
                });
            }
        }
    };

    // Set up and make the request.
    request.open('GET', 'Dropdown.aspx', true);
    request.send();
});