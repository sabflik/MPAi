//This script file is only referenced by the Scoreboard.aspx file. It controls all behaviour of the Scoreboard module
//and makes use of functions declared in the main.js file.
//Communicates with server via Statistics.aspx.cs class to retrieve scores.

var scores;

//Request all scores from server and populate graphs with those scores
$(document).ready(function () {

    //Request scores
    xhr('Statistics.aspx', new FormData(), function (responseText) {
        console.log(responseText);
        var data = JSON.parse(responseText);

        //Populate graphs and log any error conditions
        //The server response contains a donutScore for the current average and a list of all scores
        if (data === undefined || data === null) {
            console.log("ERROR: Couldn't retrieve data");
        } else {
            try {
                //Populate doughnut with average score
                console.log("Current Score" + data.donutScore[0].donutScore);
                populateDoughnut(data.donutScore[0].donutScore);
            }
            catch (exception) {
                console.log("Could not populate donut");
                console.log(exception);
            };

            try {
                //Populate time scale with all scores for past month
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
function populateDoughnut(score) {
    //Create data and properties for doughnut
    var data = {
        labels: [
          "Data",
          "Empty"
        ],
        datasets: [
          {
              //Data is in the form [score, empty]
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
    //Create doughnut
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
This graph shows progress of user's scores over time.
The timeInfo parameter is specific to the time period of the time scale.
*/
function populateTimeScale(timeInfo) {

    //Remove the previous time scale graph and create a new one
    //This bit of code is needed so that canvas elements don't overlap when the graph is re-drawn with
    //a different time period selection
    $('#timeScale').remove(); // this is my <canvas> element
    $('#timeScaleParent').append('<canvas id="timeScale"><canvas>');

    var ctx = document.getElementById("timeScale");

    //Set the data
    var data = {
        datasets: [{
            label: 'MPAi Score',
            data: timeInfo.dataset, //Data calculated for the specified time period
            backgroundColor: 'rgba(54, 162, 235, 0.2)',

            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 2
        }]
    };

    //Specify options and customisations
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
        //Customise tooltip format
        tooltips: {
            enabled: true,
            mode: 'single',
            callbacks: {
                title: function (tooltipItems, data) {
                    return "Date: " + tooltipItems[0].xLabel.format(timeInfo.toolTipFormat);//Tooltip for 
                    //x-axis will be formatted based on selected time period units
                },
                label: function (tooltipItems, data) {
                    return "Average Score: " + parseFloat(tooltipItems.yLabel).toFixed(2);
                }
            }
        },
        //Set the axis information
        scales: {
            xAxes: [{
                type: 'time',
                time: {
                    unit: timeInfo.unit, //Set the x-axis units based on the selected time period
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
    //Create time scale
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

//When time period is changed, get time information for that period and re-draw the time scale
$("#timeUnit").change(function () {
    var timeInfo = getTimeUnitInfo(this.value);

    populateTimeScale(timeInfo);
});

//Return different time information depending on the selected time period
function getTimeUnitInfo(timeUnit) {
    //Depending on the selected time period, the x-axis units are changed, the dataset of scores is calculated
    //differently, and the tooltip is formatted differently
    if (timeUnit === "past day") {
        return {
            unit: 'hour',
            //Get scores from the past 24 hours, aggregate them if they're from the same hour, and round down to nearest hour
            dataset: getDisplayScores(moment().subtract(24, "hours"), isSameHour, roundToHour),
            toolTipFormat: 'LT'
        };
    } else if (timeUnit === "past year") {
        return {
            unit: 'month',
            //Get scores from the past 12 months, aggregate them if they're from the same month, and round down to nearest month
            dataset: getDisplayScores(moment().subtract(12, "months"), isSameMonth, roundToMonth),
            toolTipFormat: 'MMM YYYY'
        };
    } else {
        return {
            unit: 'day',
            //Get scores from the past 31 days, aggregate them if they're from the same day, and round down to nearest day
            dataset: getDisplayScores(moment().subtract(31, "days"), isSameDay, roundToDay),
            toolTipFormat: 'Do MMM'
        };
    }
}

//This function filters out scores that don't belong to the selected time period, calculates the average
//scores for each unit of time, so that no two scores belong to the same time unit step (to avoid vertically
//aligned data plots that make the graph look ugly), and returns the processed data set of scores to be plotted.
function getDisplayScores(minTime, comparator, rounder) {

    var dataset = [];//Final set of aggregated scores 
    var prevDate;
    var scoresForDate = [];//Array of scores that belong to the same time unit step
                            //which needs to be aggregated into a single score before pushing to the dataset

    //Loop through all the scores
    for (var i = 0; i < scores.length; i++) {
        //Get time for the current score
        var currentDate = moment(scores[i].time, 'DD/MM/YYYY h:mm:ss A');
        //If the current score is within the specified time frame...
        if (minTime === null || currentDate.isSameOrAfter(minTime)) {
            //...If the current score should NOT be aggregated with the previous score...
            if (prevDate && !comparator(prevDate, currentDate) && scoresForDate.length > 0) {
                //...add the average score for the previously aggregated time unit step
                dataset.push({
                    x: rounder(prevDate),
                    y: calculateAverage(scoresForDate)
                });
                //Start a new time unit step
                scoresForDate = [];
            }
            //...If the current score SHOULD be aggregated with the previous score, simply accumulate it in an array
            scoresForDate.push(scores[i].score);
            prevDate = currentDate;
        }
    }
    //Scores from the final time unit step are aggregated and added to the dataset, as the previous loop doesn't
    //cover it
    if (scoresForDate.length > 0) {
        dataset.push({
            x: rounder(prevDate),
            y: calculateAverage(scoresForDate)
        });
        scoresForDate = [];
    }

    return dataset;
}

//Methods for rounding a given time to a particular time unit
function roundToHour(moment) {
    return moment.startOf('hour');
}

function roundToDay(moment) {
    return moment.startOf('day');
}

function roundToMonth(moment) {
    return moment.startOf('month');
}

//Methods for comparing given times based on different granularities
function isSameHour(moment1, moment2) {
    return moment1.isSame(moment2, "hour");
}

function isSameDay(moment1, moment2) {
    return moment1.isSame(moment2, "day");
}

function isSameMonth(moment1, moment2) {
    return moment1.isSame(moment2, "month");
}

//Function that calculates and returns the average of an array of numbers
function calculateAverage(array) {
    var sum = 0;
    for (var i = 0; i < array.length; i++) {
        sum = sum + parseInt(array[i]);
    }
    console.log(array);
    return (sum / array.length);
}