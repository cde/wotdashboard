class Funnel < ActiveRecord::Base
  attr_accessible :traffic_type,  :confirmed, :logged_in, :first_battle, :first_upgrade, :tank_purchase, :start_date, :end_date
end
