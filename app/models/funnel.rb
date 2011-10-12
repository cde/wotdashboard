class Funnel < ActiveRecord::Base

  attr_reader :logged_in_percentage

  def initialize(logged_in_percentage)
    @logged_in_percentage = logged_in_percentage

  end
end
