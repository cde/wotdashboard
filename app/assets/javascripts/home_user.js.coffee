# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./graphic/highcharts
#= require ./slides/slides.min.jquery
#= require ./datejs/datejs.min
#= require ./graphics

$( ->
	get_data = ->
		today = Date.today().addWeeks(-1)
		friday = Date.today()
		console.log today
		for	index in [1..4]
			begin = today.previous().monday()
			end = friday.previous().friday()
			new Wot.Graph('chart'+ ((index * 2) - 1), 'adquisition', 'direct', begin.toString("yyyy-M-dd"), end.toString("yyyy-M-dd"))
			new Wot.Graph('chart'+ (index * 2), 'adquisition', 'ads', begin.toString("yyyy-M-dd"), end.toString("yyyy-M-dd"))
		
	get_data()
	$("#slides").slides
		play: 5000
)