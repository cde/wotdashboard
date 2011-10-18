class Graphic < ActiveRecord::Base
  has_many :reports
  attr_accessible :title, :description, :chart_type
  validates_presence_of :title, :chart_type

  #chart_type: Basado en http://www.highcharts.com/
  #chart_type, se refiera a cualquiera de los tipos de chart elegido: line, column.
end
