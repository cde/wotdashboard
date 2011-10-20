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
		#parameters.series[0].data.push(row.confirmed)
		#parameters.series[1].data.push(row.logged_in)
		#parameters.series[2].data.push(row.first_battle)
		#parameters.series[3].data.push(row.first_upgrade)
		#parameters.series[4].data.push(row.tank_purchase)
		parameters.series[0].data.push(row.confirmed)
		parameters.series[1].data.push(row.logged_in)
		parameters.series[2].data.push(row.first_battle)
		parameters.series[3].data.push(row.first_upgrade)
		parameters.series[4].data.push(row.tank_purchase)
			
		if date_range != row.start_date + "<br>" + row.end_date
			#parameters.categories.push(row.start_date + "<br>" + row.end_date)
			date_range = row.start_date + "<br>" + row.end_date
	parameters