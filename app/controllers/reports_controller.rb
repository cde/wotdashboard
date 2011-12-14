require 'wot/process_file'
class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @reports = Report.order("created_at desc").limit(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  def show
    @report = Report.find(params[:id])
    @ads_funnels = Funnel.where("start_date>=? and end_date<=?", @report.starts_date, @report.ends_date).where(traffic_type: "Ads").order("start_date ASC")
    @direct_funnels = Funnel.where("start_date>=? and end_date<=?", @report.starts_date, @report.ends_date).where(traffic_type: "Direct").order("start_date ASC")
    respond_to do |format|
      if !@ads_funnels.empty? &&
          !@direct_funnels.empty?
        format.html # show.html.erb
        format.json { render json: @report }
      else
        flash[:notice] = "Couldn't find funnels in that range'"
        render 'index'
      end
    end
  end

  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def create
    @report = Report.new(params[:report])
    if params[:report] && params[:report][:data] &&
       (params[:report][:starts_date].nil? || params[:report][:ends_date].nil?)

      @funnels = Wot::ProcessFile.load_data((params[:report][:data].tempfile).to_path)

      unless @funnels.empty?
        values = {first_week: @funnels[:ads][0][:week],
                  last_week: @funnels[:ads][@funnels[:ads].length - 2][:week]}

        starts_date_report = Wot::ProcessFile.check_week(values[:first_week])[:start]
        ends_date_report = Wot::ProcessFile.check_week(values[:last_week])[:end]

        @report.starts_date = Date.parse(starts_date_report.to_s)
        @report.ends_date = Date.parse(ends_date_report.to_s)
        @report.title = "Generated report from #{starts_date_report.to_s} to #{ends_date_report.to_s} "
        @report.funnels << Wot::ProcessFile.create_funnels(@funnels[:ads], "Ads")
        @report.funnels << Wot::ProcessFile.create_funnels(@funnels[:direct], "Direct")

      end
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :ok }
    end
  end
end
