var scores;

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
                console.log(exception);
            };

            try {
                console.log("Number of Scores" + data.scores.length);
                scores = data.scores;
                populateTimeScale(getTimeUnitInfo('past month'));
            }
            catch (exception) {
                console.log("Could not populate time scale");
                console.log(exception);
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
function populateTimeScale(timeInfo) {

    $('#timeScale').remove(); // this is my <canvas> element
    $('#timeScaleParent').append('<canvas id="timeScale"><canvas>');

    var ctx = document.getElementById("timeScale");

    var data = {
        datasets: [{
            label: 'MPAi Score',
            data: timeInfo.dataset,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',

            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 2
        }]
    };

    var options = {
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
        tooltips: {
            enabled: true,
            mode: 'single',
            callbacks: {
                title: function (tooltipItems, data) {
                    return "Date: " + tooltipItems[0].xLabel.format(timeInfo.toolTipFormat);
                },
                label: function (tooltipItems, data) {
                    return "Average Score: " + parseFloat(tooltipItems.yLabel).toFixed(2);
                }
            }
        },
        scales: {
            xAxes: [{
                type: 'time',
                time: {
                    unit: timeInfo.unit,
                    displayFormats: {
                        'hour': 'h:mm a',
                        'day': 'MMM DD',
                        'month': 'YYYY MMM',
                        'year': 'YYYY',
                    }
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

$("#timeUnit").change(function () {
    var timeInfo = getTimeUnitInfo(this.value);

    populateTimeScale(timeInfo);
});

function getTimeUnitInfo(timeUnit) {
    if (timeUnit === "past day") {
        return {
            unit: 'hour',
            dataset: getDisplayScores(moment().subtract(24, "hours"), isSameHour, roundToHour),
            toolTipFormat: 'LT'
        };
    } else if (timeUnit === "past year") {
        return {
            unit: 'month',
            dataset: getDisplayScores(moment().subtract(12, "months"), isSameMonth, roundToMonth),
            toolTipFormat: 'MMM YYYY'
        };
    } else {
        return {
            unit: 'day',
            dataset: getDisplayScores(moment().subtract(31, "days"), isSameDay, roundToDay),
            toolTipFormat: 'Do MMM'
        };
    }
}

function getDisplayScores(minTime, comparator, rounder) {
    var dataset = [];
    var prevDate;
    var scoresForDate = [];

    for (var i = 0; i < scores.length; i++) {
        var currentDate = moment(scores[i].time, 'DD/MM/YYYY h:mm:ss A');

        if (minTime === null || currentDate.isSameOrAfter(minTime)) {
            if (prevDate && !comparator(prevDate, currentDate) && scoresForDate.length > 0) {
                dataset.push({
                    x: rounder(prevDate),
                    y: calculateAverage(scoresForDate)
                });
                scoresForDate = [];
            }
            scoresForDate.push(scores[i].score);
            prevDate = currentDate;
        }
    }

    if (scoresForDate.length > 0) {
        dataset.push({
            x: rounder(prevDate),
            y: calculateAverage(scoresForDate)
        });
        scoresForDate = [];
    }

    return dataset;
}

function roundToHour(moment) {
    return moment.startOf('hour');
}

function roundToDay(moment) {
    return moment.startOf('day');
}

function roundToMonth(moment) {
    return moment.startOf('month');
}

function isSameHour(moment1, moment2) {
    return moment1.isSame(moment2, "hour");
}

function isSameDay(moment1, moment2) {
    return moment1.isSame(moment2, "day");
}

function isSameMonth(moment1, moment2) {
    return moment1.isSame(moment2, "month");
}

function calculateAverage(array) {
    var sum = 0;
    for (var i = 0; i < array.length; i++) {
        sum = sum + parseInt(array[i]);
    }
    console.log(array);
    return (sum / array.length);
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