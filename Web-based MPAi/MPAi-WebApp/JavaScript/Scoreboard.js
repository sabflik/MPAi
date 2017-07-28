//Populate all graphs
$(document).ready(function () {
    var formData = new FormData();

    xhr('Statistics.aspx', formData, function (responseText) {
        console.log(responseText);
        var data = JSON.parse(responseText);

        if (data === undefined || data === null) {
            console.log("ERROR: Couldn't retrieve data");
        } else {
            try {
                console.log("Current Score" + data.donutScore[0].donutScore);
                populateDonut(data.donutScore[0].donutScore);
            }
            catch (exception) {
                console.log("Could not populate donut");
            };

            try {
                console.log("Number of Scores" + data.scores.length);
                populateTimeScale(data.scores);
            }
            catch (exception) {
                console.log("Could not populate time scale");
            };
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
                "#f8f8f8"
              ],
              hoverBackgroundColor: [
                "#FF6384",
                "#f8f8f8"
              ]
          }]
    };

    //Set text in middle of doughnut
    //Code adapted from https://jsfiddle.net/cmyker/ooxdL2vj/
    var centreTextPlugin = {
        beforeDraw: function (chart) {
            var width = chart.chart.width,
                height = chart.chart.height,
                ctx = chart.chart.ctx;

            ctx.restore();
            var fontSize = (height / 114).toFixed(2);
            ctx.font = fontSize + "em sans-serif";
            ctx.textBaseline = "middle";

            var text = score + "%",
                textX = Math.round((width - ctx.measureText(text).width) / 2),
                textY = height / 2;

            ctx.fillText(text, textX, textY);
            ctx.save();
        }
    };

    new Chart(document.getElementById('doughnut'), {
        type: 'doughnut',
        data: data,
        plugins: [centreTextPlugin],
        options: {
            responsive: true,
            legend: { display: false },
            tooltips: { enabled: false }
        }
    });
}


/*TIME SCALE graph
This graph shows progress of user's scores over time
*/
function populateTimeScale(scores) {

    var ctx = document.getElementById("timeScale");

    var dataset = [];

    for (var i = 0; i < scores.length; i++) {
        dataset.push({
            x: moment(scores[i].time, 'DD/MM/YYYY'),
            y: scores[i].score
        });
    }

    var data = {
        datasets: [{
            label: 'MPAi Score',
            data: dataset,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',

            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 2
        }]
    };

    var options = {
        animation: false,
        layout: {
            padding: {
                left: 20,
                right: 20,
                top: 0,
                bottom: 0
            }
        },
        legend: {
            display: false
        },
        scales: {
            xAxes: [{
                type: 'time',
                time: {
                    unit: 'month'
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Time'
                }
            }, ],
            yAxes: [{
                ticks: {
                    max: 100,
                    min: 0,
                    stepSize: 10
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Score'
                }
            }]
        },
    }

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
    Chart.defaults.global.defaultFontFamily = '"Open Sans", Arial, sans-serif';
    Chart.defaults.global.defaultFontSize = 12;
    Chart.defaults.global.defaultFontColor = '#000';
    Chart.defaults.global.defaultFontStyle = 500;
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