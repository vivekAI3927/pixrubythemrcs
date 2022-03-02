//= require jquery-3.2.1.min
//= require bootstrap.min
//= require thumbnail-slider
//= require presentational-only
//= require jquery-countTo
//= require anounce
//= require linechart
//= require rumca.min
//= require example
//= require jquery.AshAlom.gaugeMeter-2.0.0.min
//= require amcharts
//= require serial
//= require amstock
//= require SimpleChart





// count to 100
// $(".timer-a").countTo(50);
// count to 100 over 5 seconds (default is 1s)
// $(".timer-a").countTo(50, {"duration": 5});

// count to 100 over 5 seconds (default is 1s)
// $(".timer-b").countTo(100, {"duration": 5});

(function(document) {
var _bars = [].slice.call(document.querySelectorAll('.bar-inner'));
_bars.map(function(bar, index) {
setTimeout(function() {
	bar.style.width = bar.dataset.percent;
}, index * 1000);

});
})(document)


var chartData = generateChartData();
function generateChartData() {
  var chartData = [];
  var firstDate = new Date( 2012, 0, 1 );
  firstDate.setDate( firstDate.getDate() - 500 );
  firstDate.setHours( 0, 0, 0, 0 );

  for ( var i = 0; i < 500; i++ ) {
    var newDate = new Date( firstDate );
    newDate.setDate( newDate.getDate() + i );

    var value = Math.round( Math.random() * ( 40 + i ) ) + 100 + i;

    chartData.push( {
      date: newDate,
      value: value
    } );
  }
  return chartData;
}

var chart = AmCharts.makeChart( "chartdiv", {

  type: "stock",
  "theme": "light",

  dataSets: [ {

    color: "#b0de09",
    fieldMappings: [ {
      fromField: "value",
      toField: "value"
    } ],
    dataProvider: chartData,
    categoryField: "date"
  } ],

  panels: [ {
    showCategoryAxis: true,
    title: "Value",
    eraseAll: false,
    allLabels: [ {
      x: 0,
      y: 115,
      text: "",
      align: "center",
      size: 16
    } ],

    stockGraphs: [ {
      id: "g1",
      valueField: "value",
      useDataSetColors: false
    } ],


    stockLegend: {
      valueTextRegular: " ",
      markerType: "none"
    },

    drawingIconsEnabled: true
  } ],

  chartScrollbarSettings: {
    graph: "g1"
  },
  chartCursorSettings: {
    valueBalloonsEnabled: true
  },
  periodSelector: {
    position: "bottom",
    periods: [ {
      period: "DD",
      count: 10,
      label: "10 days"
    }, {
      period: "MM",
      count: 1,
      label: "1 month"
    }, {
      period: "YYYY",
      count: 1,
      label: "1 year"
    }, {
      period: "YTD",
      label: "YTD"
    }, {
      period: "MAX",
      label: "MAX"
    } ]
  }
} );

var chartData = generateChartData();
function generateChartData() {
  var chartData = [];
  var firstDate = new Date( 2012, 0, 1 );
  firstDate.setDate( firstDate.getDate() - 500 );
  firstDate.setHours( 0, 0, 0, 0 );

  for ( var i = 0; i < 500; i++ ) {
    var newDate = new Date( firstDate );
    newDate.setDate( newDate.getDate() + i );

    var value = Math.round( Math.random() * ( 40 + i ) ) + 100 + i;

    chartData.push( {
      date: newDate,
      value: value
    } );
  }
  return chartData;
}


var chart = AmCharts.makeChart( "chartdivone", {

  type: "stock",
  "theme": "light",

  dataSets: [ {
    color: "#b0de09",
    fieldMappings: [ {
      fromField: "value",
      toField: "value"
    } ],
    dataProvider: chartData,
    categoryField: "date"
  } ],

  panels: [ {
    showCategoryAxis: true,
    title: "Value",
    eraseAll: false,
    allLabels: [ {
      x: 0,
      y: 115,
      text: "",
      align: "center",
      size: 16
    } ],

    stockGraphs: [ {
      id: "g1",
      valueField: "value",
      useDataSetColors: false
    } ],


    stockLegend: {
      valueTextRegular: " ",
      markerType: "none"
    },

    drawingIconsEnabled: true
  } ],

  chartScrollbarSettings: {
    graph: "g1"
  },
  chartCursorSettings: {
    valueBalloonsEnabled: true
  },
  periodSelector: {
    position: "bottom",
    periods: [ {
      period: "DD",
      count: 10,
      label: "10 days"
    }, {
      period: "MM",
      count: 1,
      label: "1 month"
    }, {
      period: "YYYY",
      count: 1,
      label: "1 year"
    }, {
      period: "YTD",
      label: "YTD"
    }, {
      period: "MAX",
      label: "MAX"
    } ]
  }
} );

var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-36251023-1']);
_gaq.push(['_setDomainName', 'jqueryscript.net']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();


$( document ).ready(function() {
	var chartData = {
		node: "graph",
		dataset: [122, 65, 80, 84, 33, 55, 95, 15, 268, 47, 72, 69],
		labels: ["id-1", "id-2", "id-3", "id-4", "id-5", "id-6", "id-7", "id-8", "id-9", "id-10", "id-11", "id-12"],
		pathcolor: "#288ed4",
		fillcolor: "#8e8e8e",
		xPadding: 0,
		yPadding: 0,
		ybreakperiod: 50
	};

});

$(document).ready(function(){
	$(".BOthCHgat").hide();
	  $(".BooThANa").click(function(){
	$(".BOthCHgat").show();

	});
});
$(document).ready(function(){
	$(".ChartsixstyLe").hide();
	  $(".BooThANaone").click(function(){
	$(".ChartsixstyLe").show();
	});
});

$(".GaugeMeter").gaugeMeter();
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);
function drawBasic() {
  var data = new google.visualization.DataTable();
  data.addColumn('number', 'X');
  data.addColumn('number', '');

  data.addRows([
    [0, 0],   [1, 10],  [2, 23],  [3, 17],  [4, 18],  [5, 9],
    [6, 11],  [7, 27],  [8, 33],  [9, 40],  [10, 32], [11, 35],
    [12, 30], [13, 40], [14, 42], [15, 47], [16, 44], [17, 48],
    [18, 52], [19, 54], [20, 42], [21, 55], [22, 56], [23, 57],
    [24, 60], [25, 50], [26, 52], [27, 51], [28, 49], [29, 53],
    [30, 55], [31, 60], [32, 61], [33, 59], [34, 62], [35, 65],
    [36, 62], [37, 58], [38, 55], [39, 61], [40, 64], [41, 65],
    [42, 63], [43, 66], [44, 67], [45, 69], [46, 69], [47, 70],
    [48, 72], [49, 68], [50, 66], [51, 65], [52, 67], [53, 70],
    [54, 71], [55, 72], [56, 73], [57, 75], [58, 70], [59, 68],
    [60, 64], [61, 60], [62, 65], [63, 67], [64, 68], [65, 69],
    [66, 70], [67, 72], [68, 75], [69, 80]
  ]);

  var options = {
    hAxis: {
      title: 'Event Id'
    },
    vAxis: {
      title: 'No of Visitor Engaged'
    },

height:400
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

  chart.draw(data, options);
}

var graphdata1 = {
  linecolor: "#CCA300",
  title: "Monday",
  values: [
  { X: "id 1", Y: 10.00 },
  { X: "id 2", Y: 20.00 },
  { X: "id 3", Y: 40.00 },
  { X: "id 4", Y: 34.00 },
  { X: "id 5", Y: 40.25 },
  { X: "id 6", Y: 28.56 },
  { X: "id 7", Y: 18.57 },
  { X: "id 8", Y: 70.00 }
  ]
};

$(function () {
	$("#Linegraph").SimpleChart({
    ChartType: "Line",
    toolwidth: "50",
    toolheight: "25",
    axiscolor: "#E6E6E6",
    textcolor: "#6E6E6E",
    showlegends:false,
    data: [graphdata1],
    xaxislabel: 'Event Id',
    yaxislabel: 'No of users Engaged'
	});
});
