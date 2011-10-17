# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

if User.all.empty?
  puts 'SETTING UP DEFAULT USER LOGIN'
  user = User.create! :username => 'jeremy', :email => 'jeremy@test.com', :password => 'password', :password_confirmation => 'password'
  puts 'New user created: ' << user.name
end


if Funnel.all.empty? && Rails.env == 'development'
 start_time, end_time = nil
(1..36).each do |i|


    if start_time.nil? && end_time.nil?
      start_time = DateTime.new(2011, 01, 03)
      end_time = start_time + 1.week
    else
      start_time = end_time + 1.day
      end_time = start_time + 1.week
    end
    Funnel.create(:traffic_type => 'Direct', :confirmed => 1000 * i, :logged_in => 950  * i, :first_battle=> 930  * i,:first_upgrade => 900  * i, :tank_purchase => 800  * i, :start_date => start_time, :end_date => end_time )
    Funnel.create(:traffic_type => 'Ads', :confirmed => 500  * i, :logged_in => 450  * i, :first_battle=> 430, :first_upgrade => 400  * i, :tank_purchase => 200, :start_date => start_time, :end_date => end_time )
  end
end
