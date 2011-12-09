class Report < ActiveRecord::Base
  belongs_to :graphic

  has_many :funnels

  attr_accessible :starts_date, :ends_date, :title, :note, :data
  validates_presence_of :starts_date, :ends_date, :title
  validates_uniqueness_of :title

  mount_uploader :data, DataUploader

  scope :ads, where(traffic_type: "Ads").order("start_date asc")
  scope :direct, where(traffic_type: "Direct").order("start_date asc")

end
