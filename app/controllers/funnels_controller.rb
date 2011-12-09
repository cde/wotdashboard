require 'wot/process_file'
require "base64"


class FunnelsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def preview
    unless params[:funnels].nil?
      begin
        uploader = DataUploader.new
        uploader.store!(params[:funnels][:file])
        logger.warn "uploader #{uploader.inspect}"
        @funnels = Wot::ProcessFile.load_data((params[:funnels][:file].tempfile).to_path, true)
        unless @funnels.empty?
          @data_file = Base64.encode64(params[:funnels][:file].original_filename)
        end
      rescue Exception => e
        flash[:error] = e.message
        redirect_to funnels_path
      end
    else
      flash[:error] = "Data file is empty"
      redirect_to funnels_path
    end
  end

  def process_file
    unless params[:data_file].nil?
      begin
        #Todo: we'll probably store this in amazon s3'
        dir_store = (Rails.env == :production) ? "data/" : "public/data/"
        funnels = Wot::ProcessFile.load_data(dir_store + Base64.decode64(params[:data_file]))
        if funnels
          Wot::ProcessFile.create_funnels(funnels[:ads], "Ads")
          Wot::ProcessFile.create_funnels(funnels[:direct], "Direct")
          flash[:notice] = "Your data file is saved"
          redirect_to funnels_path
        end

      rescue Exception => e
        flash[:error] = e.message
        redirect_to funnels_path
      end
    else
      flash[:error] = "An unexpected error occurred, please try again"
      redirect_to funnels_path
    end
  end

  def get_data_normal
    @funnel_data = Funnel.select("id, traffic_type, confirmed, logged_in, first_battle, first_upgrade, tank_purchase, start_date").where(:start_date => (params[:start].to_date)..(params[:end].to_date), :traffic_type => params[:traffic_type])
    respond_to do |format|
      format.json { render :json => @funnel_data }
    end
  end
  
  def get_data_adquisition
    @funnel_data = Funnel.select("sum(traffic_type) traffic_type, sum(confirmed) confirmed, sum(logged_in) logged_in, sum(first_battle) first_battle, sum(first_upgrade) first_upgrade, sum(tank_purchase) tank_purchase").where(:start_date => (params[:start].to_date)..(params[:end].to_date), :traffic_type => params[:traffic_type])
    respond_to do |format|
      format.json { render :json => @funnel_data }
    end
  end

  def save_report
    graph = Graphic.where(:chart_type => params[:report][:chart_type])
    report = Report.new(params[:report])
    report.graphic_id = graph
    report.user_id = current_user.id
    if report.save
      render :json => {status: 200, id: report.id, title_slug: report.title_slugize}
    else
      render :json => {status: 101, error: report.errors}
    end
  end
  
  def update_report
    graph = Graphic.where(:chart_type => params[:report][:chart_type])
    report = Report.find(params[:report][:id])
    params[:report][:graphic_id] = graph[0].id
    
    if report.update_attributes(params[:report])
      render :json => {status: 200}
    else
      render :json => {status: 101, error: report.errors}
      pry.binding
    end
  end
end
