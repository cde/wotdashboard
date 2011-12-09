class Funnel < ActiveRecord::Base
  belongs_to :report
  attr_accessible :traffic_type,  :confirmed, :logged_in, :first_battle, :first_upgrade, :tank_purchase, :start_date, :end_date

end
