class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :last_reports
  
  def last_reports
    @last_reports = Report.select('id, title').order("created_at").limit(10)
  end
end
