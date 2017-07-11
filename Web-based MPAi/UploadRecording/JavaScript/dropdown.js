//Code modified from: https://codepen.io/matt-west/pen/jKnzG

// Get the <datalist> and <input> elements.
var dataList = document.getElementById('json-datalist');
var input = document.getElementById('maoriWord');

// Create a new XMLHttpRequest.
var request = new XMLHttpRequest();

// Handle state changes for the request.
request.onreadystatechange = function (response) {
    if (request.readyState === 4) {
        if (request.status === 200) {
            // Parse the JSON
            var jsonOptions = JSON.parse(request.responseText);

            var words = [];

            $.each(jsonOptions.oldfemale, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    // Create a new <option> element.
                    var option = document.createElement('option');
                    // Set the value using the item in the JSON array.
                    option.value = v.name;
                    // Add the <option> element to the <datalist>.
                    dataList.appendChild(option);

                    words.push(v.name);
                }
            });

            $.each(jsonOptions.oldmale, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    // Create a new <option> element.
                    var option = document.createElement('option');
                    // Set the value using the item in the JSON array.
                    option.value = v.name;
                    // Add the <option> element to the <datalist>.
                    dataList.appendChild(option);

                    words.push(v.name);
                }
            });

            $.each(jsonOptions.youngmale, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    // Create a new <option> element.
                    var option = document.createElement('option');
                    // Set the value using the item in the JSON array.
                    option.value = v.name;
                    // Add the <option> element to the <datalist>.
                    dataList.appendChild(option);

                    words.push(v.name);
                }
            });

            $.each(jsonOptions.youngfemale, function (i, v) {
                if ($.inArray(v.name, words) === -1) {
                    // Create a new <option> element.
                    var option = document.createElement('option');
                    // Set the value using the item in the JSON array.
                    option.value = v.name;
                    // Add the <option> element to the <datalist>.
                    dataList.appendChild(option);

                    words.push(v.name);
                }
            });

            // Update the placeholder text.
            input.placeholder = "Search...";
        } else {
            // An error occured :(
            input.placeholder = "Error loading word options";
        }
    }
};

// Update the placeholder text.
input.placeholder = "Loading options...";

// Set up and make the request.
request.open('GET', 'Dropdown.aspx', true);
request.send();