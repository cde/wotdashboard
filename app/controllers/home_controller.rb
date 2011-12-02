class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if !current_user.admin
      render 'user_index'
    end
    #render :text => "Este va a ser el home page"
  end

end
