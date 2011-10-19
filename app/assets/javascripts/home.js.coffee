# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#begin').DatePicker
		format:'m/d/Y'
		date: new Date
		starts: 1
		position: 'right'
		onBeforeShow: ()->
			$('#begin').DatePickerSetDate $('#begin').val(), true
		onChange: (formated, dates)->
			$('#begin').val(formated);
			$('#begin').DatePickerHide()
	
	$('#end').DatePicker
		format:'m/d/Y'
		date: new Date
		starts: 1
		position: 'right'
		onBeforeShow: ()->
			$('#end').DatePickerSetDate $('#end').val(), true
		onChange: (formated, dates)->
			$('#end').val(formated);
			$('#end').DatePickerHide()