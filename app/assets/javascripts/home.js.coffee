# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./picker/datepicker
#= require ./graphic/highcharts
#= require ./graphic/modules/exporting
#= require ./graphic/modules/funnel
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
#				console.log(aux_date[1] + '-' + aux_date[2] + '-' + aux_date[0])
				console.log new_date
				parameters.categories.push(short_month_data[new_date.getMonth()] + ' ' + new_date.getDate())
				console.log parameters.categories
				date_range = row.start_date
		parameters

	generate_graph = (parameters, container, title, type_graphic)->
		if type_graphic == 'funnel'
		  generate_graph_funnel(parameters, container, title)
		else
		  generate_graph_normal(parameters, container, title, type_graphic)

	generate_graph_funnel = (parameters, container, title)->
		chart = new Highcharts.Chart
			chart:
				renderTo: container
				defaultSeriesType: 'funnel'
				margin: [50, 10, 60, 170]
				borderWidth: 1
			title:
				text: title
				x: -20 #center
			plotArea:
				shadow: null
				borderWidth: null
				backgroundColor: null
			tooltip:
				formatter: ()->
					'<b>'+ this.series.name + '</b><br/>' + this.x + ': ' + this.y
			plotOptions:
				series:
					dataLabels:
						align: 'left'
						x: -300
						enabled: true
						formatter: ()->
							'<b>'+ this.point.name +'</b> ('+ Highcharts.numberFormat(this.point.y, 0) +')'
			legend:
				enabled: false
			series: [
				name: 'help'
				data: [ ['opcion1', 1233], ['downloads', 32333], ['request', 34444]]
				]
			credits:
				enabled: false
			exporting:
				enabled: false

	generate_graph_normal = (parameters, container, title, type_graphic)->
		plot_options = {}
		stack_labels = {}
		if type_graphic == 'column'
			plot_options =
				column:
					stacking: 'normal'
					dataLabels:
						enabled: true
						color: 'white'
			stack_labels:
				enabled: true
				style:
					fontWeight: 'bold'
					color: 'gray'
		chart = new Highcharts.Chart
			chart:
				renderTo: container
				defaultSeriesType: type_graphic
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
				stackLabels: stack_labels
			tooltip:
				formatter: ()->
					'<b>'+ this.series.name + '</b><br/>' + this.x + ': ' + this.y
			plotOptions: plot_options
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

	get_data = (type_graphic)->
		$.getJSON '/funnels/'+ $('#begin').val()+'/'+$('#end').val()+'/Direct.json', (data)->
			parameters = format_data(data)
			generate_graph(parameters, 'chart1', 'Direct', type_graphic)
		$.getJSON '/funnels/'+ $('#begin').val()+'/'+$('#end').val()+'/Ads.json', (data)->
			parameters = format_data(data)
			generate_graph(parameters, 'chart2', 'Ads', type_graphic)

	get_data('line')

	get_graphic_type = ->
		if $('ul.pills li.active a').html() == 'Lines'
			return 'line'
		if $('ul.pills li.active a').html() == 'Bars'
		  return 'column'
		if $('ul.pills li.active a').html() == 'Funnels'
			return 'funnel'

	$('ul.pills li a').click (event)->
		event.preventDefault()
		$('ul.pills li').removeClass('active')
		$(this).parent('li').addClass('active')
		get_data(get_graphic_type())

	$('#generate').click (event)->
		event.preventDefault()
		get_data(get_graphic_type())
	
	new DatePicker("#begin");
	new DatePicker("#end");
