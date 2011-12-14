# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./graphic/highcharts
#= require ./slides/slides.min.jquery
#= require ./datejs/datejs.min
#= require ./graphics

$ ->
	get_data = ->
		$.get '/funnels/get_dates', (data)->
			index = 1
			for	temp_date in data.dates
				new Wot.Graph('chart'+ ((index * 2) - 1), 'adquisition', 'direct', temp_date.starts, temp_date.ends)
				new Wot.Graph('chart'+ (index * 2), 'adquisition', 'ads', temp_date.starts, temp_date.ends)
				index++
			$("#slides").slides
				play: 5000
	get_data()
	
