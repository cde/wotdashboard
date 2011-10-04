class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    #render :text => "Este va a ser el home page"
  end

end
