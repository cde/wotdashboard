# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	format_data = (data)->
		parameters =
			categories: []
			series: [ {name: 'Direct - confirmed', data: []},
								{name: 'Direct - logged_in', data: []},
								{name: 'Direct - first_battle', data: []},
								{name: 'Direct - first_upgrade', data: []},
								{name: 'Direct - tank_purchase', data: []},
								{name: 'Ads - confirmed', data: []},
								{name: 'Ads - logged_in', data: []},
								{name: 'Ads - first_battle', data: []},
								{name: 'Ads - first_upgrade', data: []},
								{name: 'Ads - tank_purchase', data: []} ]
		date_range = ''
		for row in data
			if row.traffic_type == 'Direct'
				parameters.series[0].data.push(row.confirmed)
				parameters.series[1].data.push(row.logged_in)
				parameters.series[2].data.push(row.first_battle)
				parameters.series[3].data.push(row.first_upgrade)
				parameters.series[4].data.push(row.tank_purchase)
			else
				parameters.series[5].data.push(row.confirmed)
				parameters.series[6].data.push(row.logged_in)
				parameters.series[7].data.push(row.first_battle)
				parameters.series[8].data.push(row.first_upgrade)
				parameters.series[9].data.push(row.tank_purchase)
				
			if date_range != row.start_date + "<br>" + row.end_date
				parameters.categories.push(row.start_date + "<br>" + row.end_date)
				date_range = row.start_date + "<br>" + row.end_date
		parameters
			
	generate_graph = (parameters)->
		chart = new Highcharts.Chart
			chart:
				renderTo: 'chart'
				defaultSeriesType: 'spline'
				marginRight: 230
				marginBottom: 45
			title: 
				text: 'Reporte'
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
					'<b>'+ this.series.name + '</b><br/>' + this.x.replace('<br>','/') + ': ' + this.y
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
		$.getJSON '/funnels/'+ $('#begin').val()+'/'+$('#end').val()+'.json', (data)->
			parameters = format_data(data)
			generate_graph parameters
			
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