//Populate all graphs
$(document).ready(function () {
    var formData = new FormData();

    xhr('Statistics.aspx', formData, function (responseText) {
        var data = JSON.parse(responseText);

        if (data === undefined || data === null) {
            console.log("ERROR: Couldn't retrieve data");
        } else {
            console.log("Score"+ data.score);
            populateDonut(data.score);
        }
    });  
});

/*DONUT graph
This graph shows current average score of user
*/
function populateDonut(score) {

    var data = {
        labels: [
          "Data",
          "Empty"
        ],
        datasets: [
          {
              data: [score, 100 - score],
              backgroundColor: [
                "#FF6384",
                "#FFFFFF"
              ],
              hoverBackgroundColor: [
                "#FF6384",
                "#FFFFFF"
              ]
          }]
    };

    //Set text in middle of doughnut
    //Code adapted from https://jsfiddle.net/cmyker/ooxdL2vj/
    Chart.pluginService.register({
        beforeDraw: function (chart) {
            var width = chart.chart.width,
                height = chart.chart.height,
                ctx = chart.chart.ctx;

            ctx.restore();
            var fontSize = (height / 114).toFixed(2);
            ctx.font = fontSize + "em sans-serif";
            ctx.textBaseline = "middle";

            var text = score+"%",
                textX = Math.round((width - ctx.measureText(text).width) / 2),
                textY = height / 2;

            ctx.fillText(text, textX, textY);
            ctx.save();
        }
    });

    var chart = new Chart(document.getElementById('doughnut'), {
        type: 'doughnut',
        data: data,
        options: {
            responsive: true,
            legend: { display: false },
            tooltips: { enabled: false }
        }
    });
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