# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require ./picker/datepicker
#= require ./graphic/highcharts
#= require ./graphic/modules/exporting
#= require ./graphic/modules/funnel
$ ->
	create_label_graph = (chart, text, options)->
		text = chart.renderer.text(text, options.x, options.y).attr({zIndex: 5}).css({color: options.color}).add()
		box = text.getBBox()
		chart.renderer.rect(box.x - 5, box.y - 5, box.width + 10, box.height + 10, 5).attr({fill: '#FFF', stroke: 'gray', 'stroke-width': 1, zIndex: 4}).add()
	format_data_normal = (data)->
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
				aux_date = row.start_date.replace(/-/g,'/')
				new_date = new Date(aux_date)
				parameters.categories.push(short_month_data[new_date.getMonth()] + ' ' + new_date.getDate())
				date_range = row.start_date
		parameters
	format_data_adquisition = (data)->
		parameters =
			categories: []
			series: [ {name: 'Positive', data: []},
								{name: 'Negative', data: []} ]

		parameters.series[0].data = [data[0].confirmed, data[0].logged_in, data[0].first_battle, data[0].first_upgrade, data[0].tank_purchase]
		parameters.series[1].data = [ '', (data[0].confirmed - data[0].logged_in) * -1, (data[0].confirmed - data[0].first_battle) * -1, (data[0].confirmed - data[0].first_upgrade) * -1, (data[0].confirmed - data[0].tank_purchase) * -1]
		
		parameters.categories = ['Confirmed', 'Login', 'First Battle', 'First Upgrade', 'First Tank Purchase']
			
		parameters

	generate_graph = (parameters, container, title, type_graphic)->
		if type_graphic == 'adquisition'
		  generate_graph_adquisition(parameters, container, title, 'column')
		else
		  generate_graph_normal(parameters, container, title, type_graphic)

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
		chart = new Highcharts.Chart(
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
		, (chart)->
			
		)

	generate_graph_adquisition = (parameters, container, title, type_graphic)->
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
		chart = new Highcharts.Chart(
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
		, (chart)->
			for index in [0..chart.series[0].data.length - 1]
				if index > 0 && chart.series[0].data[index + 1] != undefined && chart.series[0].data[index].config != null
					aux_label = Math.round((parseFloat(chart.series[0].data[index + 1].config) * 100) / parseFloat(chart.series[0].data[index].config))
					create_label_graph chart, aux_label.toString() + "%", {y: 150, x: chart.series[0].data[index + 1].plotX + chart.plotLeft - 75, color: 'green'}
					aux_label2 = 100 - aux_label
					create_label_graph chart, aux_label2.toString() + "%", {y: 190, x: chart.series[0].data[index + 1].plotX + chart.plotLeft - 75, color: 'red'}
				if index > 0 && chart.series[0].data[index].config != null
					aux_label = (parseFloat(chart.series[0].data[index].config) * 100) / parseFloat(chart.series[0].data[0].config)
					create_label_graph chart, aux_label.toString() + "%", {y: chart.series[0].data[index].plotY + chart.plotTop - 15, x: chart.series[0].data[index].plotX + chart.plotLeft - 10, color: 'gray'}
					aux_label2 = 100 - aux_label
					create_label_graph chart, aux_label2.toString() + "%", {y: chart.series[1].data[index].plotY + chart.plotTop + 25, x: chart.series[0].data[index].plotX + chart.plotLeft - 10, color: 'gray'}
		)

	get_data = (type_graphic)->
		if type_graphic == 'adquisition'
			$.getJSON '/funnels/adquisition/'+ $('#begin').val()+'/'+$('#end').val()+'/Direct.json', (data)->
				parameters = format_data_adquisition(data)
				generate_graph(parameters, 'chart1', 'Direct', type_graphic)
			$.getJSON '/funnels/adquisition/'+ $('#begin').val()+'/'+$('#end').val()+'/Ads.json', (data)->
				parameters = format_data_adquisition(data)
				generate_graph(parameters, 'chart2', 'Direct', type_graphic)
		else
			$.getJSON '/funnels/normal/'+ $('#begin').val()+'/'+$('#end').val()+'/Direct.json', (data)->
				parameters = format_data_normal(data)
				generate_graph(parameters, 'chart1', 'Direct', type_graphic)
			$.getJSON '/funnels/normal/'+ $('#begin').val()+'/'+$('#end').val()+'/Ads.json', (data)->
				parameters = format_data_normal(data)
				generate_graph(parameters, 'chart2', 'Direct', type_graphic)

	get_data('adquisition')

	get_graphic_type = ->
		if $('ul.pills li.active a').html() == 'Lines'
			return 'line'
		if $('ul.pills li.active a').html() == 'Adquisition'
		  return 'adquisition'
		if $('ul.pills li.active a').html() == 'Bars'
			return 'column'

	$('ul.pills li a').click (event)->
		event.preventDefault()
		$('ul.pills li').removeClass('active')
		$(this).parent('li').addClass('active')
		get_data(get_graphic_type())

	$('#generate').click (event)->
		event.preventDefault()
		get_data(get_graphic_type())
	
	new DatePicker("#begin", {format: 'Y-m-d'});
	new DatePicker("#end", {format: 'Y-m-d'});
