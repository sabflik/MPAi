<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listen.aspx.cs" Inherits="UploadRecording.Listen" %>

<!DOCTYPE html>

<html>
<head runat="server">
        <title>MPAi-Listen</title>
        <meta charset="utf-8" />
        <style>
            input {
                border: 1px solid rgb(49, 79, 79);
                border-radius: 3px;
                font-size: 1em;
                width: 100px;
                text-align: center;
                vertical-align: bottom;
            }

            button {
                border: 1px solid rgb(49, 79, 79);
                border-radius: 3px;
                vertical-align: bottom;
                height: auto;
                font-size: inherit;
            }
            select {
                border: 1px solid rgb(49, 79, 79);
                border-radius: 3px;
                vertical-align: bottom;
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
        }
        </style>
    </head>
<body>
    <div style="margin:0 auto; width:500px; height:100px;">
            <section style="padding: 5px;">
                <ul>
                    <li><a class="active" href="index.aspx">Speak</a></li>
                    <li><a class="active" href="Listen.aspx">Listen</a></li>
                </ul>
                <br />
                <div>
                    <label>Category: </label>
                    <select id ="category">
                        <option value="youngfemale">Young Female</option>
                        <option value="oldfemale">Old Female</option>
                        <option value="youngmale">Young Male</option>
                        <option value="oldmale">Old Male</option>
                    </select>
                    <label for="maoriWord">Maori word:</label>
                    <input type="text" id="maoriWord"/>
                    <button id="search">Search</button>
                    <br />
                    <label style="color:purple">Please double the vowels to show long vowels.</label>
                </div>
            </section>

            <section style ="padding: 5px;">
                <div>
                    <p>
                        <audio id="player" src="" controls="controls">
                        </audio> 
                        <br />
                        <button id="change">Change</button>
                    </p>
                </div>
                <div id="result" style="color:purple"></div>
            </section>
    </div>

    <script>

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
                    player.src = obj.resultJsonTable[0].path;
                }
            });
        };
        // Button 'change' action
        document.querySelector('#change').onclick = function () {
            count++;
            if (count >= obj.resultJsonTable.length) {
                count = 0;
            }
            player.src = obj.resultJsonTable[count].path;
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
    </script>
</body>
</html>
