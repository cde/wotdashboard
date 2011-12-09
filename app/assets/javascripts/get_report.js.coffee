# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./picker/datepicker
#= require ./graphic/highcharts
#= require ./graphics

$( ->
	try_again = false
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
	
	$('#modal_save').click (event)->
		if $("#report_title").val() != ''
			$('#report_form').hide()
			$('#report_loading').show()
			$.post '/funnels/save_report', {report: {starts_date: $('#begin').val(),ends_date: $('#end').val(),title: $("#report_title").val(),note: $('#report_note').val(),chart_type: get_graphic_type()}}, (data)->
				console.log data
				if data.status == 200
					$('#modal-save-as').modal('hide')
					location.href = '/' + data.id + '/' + data.title_slug
				else
					$('#report_form').hide()
					$('#report_loading').hide()
					$('#report_error').show()
					if data.error.title != null
						list = '<ul>'
						for error in data.error.title
							list += '<li>' + error + '</li>'
							console.log error
						list += '</ul>'
						$('#report_error').append(list)
						$('#modal_save').hide()
						$('#modal_try').show()
			.error ->
				$('#report_form').hide()
				$('#report_loading').hide()
				$('#report_error').show()
				$('#report_title').val('')
				$('#report_note').val('')
		else
			$('#report_form').hide()
			$('#report_loading').hide()
			$('#report_error').show()
			$('#report_error').append("<ul><li>Title is empty</li></ul>")
			$('#modal_save').hide()
			$('#modal_try').show()
	$('#modal_cancel').click (event)->
		$('#modal-save-as').modal('hide')
	$('#modal_try').click (event)->
		$('#report_form').show()
		$('#report_loading').hide()
		$('#report_error').hide()
		$('#modal_save').show()
		$('#modal_try').hide()
	$('#modal-save-as').bind 'hidden', ->
		$('#report_form').show()
		$('#report_loading').hide()
		$('#report_error').hide()
		$('#report_title').val('')
		$('#report_note').val('')
		$('#modal_save').show()
		$('#modal_try').hide()
		$('#report_error').html("<h2>Error</h2>")
	update_report = ->
		$('#report_loading_save').show()
		$('#report_error_save').hide()
		$('#report_error_save').html("<h2>Error</h2>")
		$.post '/funnels/update_report', {report: {id: $('#report_id').val(),starts_date: $('#begin').val(),ends_date: $('#end').val(),title: $("#report_title_def").val(),note: $('#report_note_def').val(),chart_type: get_graphic_type()}}, (data)->
			if data.status == 200
				$('#modal-save').modal('hide')
			else
				$('#report_loading_save').hide()
				$('#report_error_save').show()
				if data.error.title != null
					list = '<ul>'
					for error in data.error.title
						list += '<li>' + error + '</li>'
						console.log error
					list += '</ul>'
					$('#report_error_save').append(list)
					$('#modal_try_save').show()
		.error ->
			$('#report_loading_save').hide()
			$('#report_error_save').show()
			$('#modal_try_save').show()
	$('#modal-save').bind 'shown', ->
		update_report()
	$('#modal_try_save').click (event)->
		update_report()
	$('#generate').click (event)->
		event.preventDefault()
		get_data()
	
	get_data()
	
	new DatePicker("#begin", {format: 'Y-m-d'});
	new DatePicker("#end", {format: 'Y-m-d'});
)