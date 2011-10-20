# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./picker/datepicker
#= require ./graphic/highcharts
#= require ./graphic/modules/exporting
$ ->
	format_data = (data)->
		parameters =
			categories: []
			series: [ {name: 'confirmed', data: []},
								{name: 'logged_in', data: []},
								{name: 'first_battle', data: []},
								{name: 'first_upgrade', data: []},
								{name: 'tank_purchase', data: []} ]
		date_range = ''
		for row in data
			parameters.series[0].data.push(row.confirmed)
			parameters.series[1].data.push(row.logged_in)
			parameters.series[2].data.push(row.first_battle)
			parameters.series[3].data.push(row.first_upgrade)
			parameters.series[4].data.push(row.tank_purchase)
				
			if date_range != row.start_date
				aux_date = row.start_date.split("-")
				new_date = new Date(aux_date[1] + '-' + aux_date[2] + '-' + aux_date[0])
				parameters.categories.push(short_month_data[new_date.getMonth()] + ' ' + new_date.getDate())
				date_range = row.start_date
		parameters
			
	generate_graph = (parameters, container, title)->
		chart = new Highcharts.Chart
			chart:
				renderTo: container
				defaultSeriesType: 'line'
				marginRight: 230
				marginBottom: 45
			title: 
				text: title
				x: -20 #center
			subtitle:
				text: 'Temp'
				x: -20
			xAxis:
				categories: parameters.categories
			yAxis:
				title:
					text: 'Users'
				plotLines: [ {value: 0, width: 1, color: '#808080'} ]
			tooltip: 
				formatter: ()-> 
					'<b>'+ this.series.name + '</b><br/>' + this.x + ': ' + this.y
			legend:
				layout: 'vertical'
				align: 'right'
				verticalAlign: 'top'
				x: -10
				y: 40
				borderWidth: 0
			series: parameters.series
			credits:
				enabled: false
			exporting:
				enabled: false
	
	get_data = ()->
		$.getJSON '/funnels/'+ $('#begin').val()+'/'+$('#end').val()+'/Direct.json', (data)->
			parameters = format_data(data)
			generate_graph parameters, 'chart1', 'Direct'
		$.getJSON '/funnels/'+ $('#begin').val()+'/'+$('#end').val()+'/Ads.json', (data)->
			parameters = format_data(data)
			generate_graph parameters, 'chart2', 'Ads'
			
	get_data()
	$('ul.pills li a').click (event)->
		event.preventDefault()
		$('ul.pills li').removeClass('active')
		$(this).parent('li').addClass('active')
	$('#generate').click (event)->
		event.preventDefault()
		get_data()
	
	$('#begin').DatePicker
		format:'Y-m-d'
		date: new Date
		starts: 1
		position: 'right'
		onBeforeShow: ()->
			$('#begin').DatePickerSetDate $('#begin').val(), true
		onChange: (formated, dates)->
			$('#begin').val(formated);
			$('#begin').DatePickerHide()
	
	$('#end').DatePicker
		format:'Y-m-d'
		date: new Date
		starts: 1
		position: 'right'
		onBeforeShow: ()->
			$('#end').DatePickerSetDate $('#end').val(), true
		onChange: (formated, dates)->
			$('#end').val(formated);
			$('#end').DatePickerHide()