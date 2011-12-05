class Graphic < ActiveRecord::Base
  has_many :reports
  attr_accessible :title, :description, :chart_type
  
  validates_presence_of :title, :chart_type
end
