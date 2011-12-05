class Report < ActiveRecord::Base
  belongs_to :graphic
  
  attr_accessible :starts_date, :ends_date, :title, :note
  validates_presence_of :starts_date, :ends_date, :title
  validates_uniqueness_of :title
end
