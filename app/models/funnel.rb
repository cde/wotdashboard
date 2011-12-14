class Funnel < ActiveRecord::Base
  belongs_to :report
  attr_accessible :traffic_type,  :confirmed, :logged_in, :first_battle, :first_upgrade, :tank_purchase, :start_date, :end_date

  scope :ads, where(traffic_type: "Ads").order("start_date asc")
  scope :direct, where(traffic_type: "Direct").order("start_date asc")
end
