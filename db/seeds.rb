# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

=begin
if User.all.empty?
  puts 'SETTING UP DEFAULT USER LOGIN'
  user = User.create! :username => 'jeremy', :email => 'jeremy@test.com', :password => 'password', :password_confirmation => 'password'
  puts 'New user created: ' << user.name
end
=end


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
    Funnel.create(:traffic_type => 'Direct', :confirmed => 10000 * i, :logged_in => (10000 * i) * 0.8, :first_battle=> (10000 * i) * 0.6,:first_upgrade => (10000 * i) * 0.4, :tank_purchase => (10000 * i) * 0.2, :start_date => start_time, :end_date => end_time )
    Funnel.create(:traffic_type => 'Ads', :confirmed => 5000  * i, :logged_in => (5000  * i) * 0.8, :first_battle=> (5000  * i) * 0.6, :first_upgrade => (5000  * i) * 0.4, :tank_purchase => (5000  * i) * 0.2, :start_date => start_time, :end_date => end_time )
  end
end
