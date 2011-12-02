# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./picker/datepicker
#= require ./graphic/highcharts
#= require ./graphics

$( ->
	get_data = ->
		new Wot.Graph('chart1', get_graphic_type(), 'ads', $('#begin').val(), $('#end').val())
		new Wot.Graph('chart2', get_graphic_type(), 'direct', $('#begin').val(), $('#end').val())

	get_graphic_type = ->
		$('ul.pills li.active a').attr('type')
	
	$('ul.pills li a').click (event)->
		event.preventDefault()
		$('ul.pills li').removeClass('active')
		$(this).parent('li').addClass('active')
		get_data()
	
	$('#save').click (event)->
		$().data('modal')
	
	$('#generate').click (event)->
		event.preventDefault()
		get_data()
	
	$('ul.pills li:first-child').addClass('active')
	
	get_data()
	
	new DatePicker("#begin", {format: 'Y-m-d'});
	new DatePicker("#end", {format: 'Y-m-d'});
)