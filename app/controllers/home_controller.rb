class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :last_reports, :only => [:index, :get_report, :results]
  
  def last_reports
    @last_reports = Report.select('id, title').order("created_at").limit(10)
  end
  
  def results
    @finding = params[:user][:title]
    @results = Report.where("title LIKE ?", "%" + params[:user][:title] + "%")
  end
  
  def index
    if current_user.admin
      @graphics = Graphic.all
    else
      render 'user_index'
    end
    #render :text => "Este va a ser el home page"
  end
  
  def get_report
    @graphics = Graphic.all
    @report = Report.find params[:id]
  end

end
