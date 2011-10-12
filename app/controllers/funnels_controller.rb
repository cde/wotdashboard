require 'wot/process_file'
require "base64"
require 'utilities'

class FunnelsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def add_files
    unless params[:funnels].nil?
      begin
        uploader = DataUploader.new
        uploader.store!(params[:funnels][:file])
        @preview = preview(params[:funnels][:file].tempfile)
        @data_file = Base64.encode64(params[:funnels][:file].original_filename)
      rescue Exception => e
        flash[:error] = e.message
        redirect_to funnels_path
      end
    else
      flash[:error] = "Data file is empty"
      redirect_to funnels_path
    end
  end

  def preview(file)
     results = CsvMapper.import(file.to_path) do
        start_at_row 1
        #stop_at_row 5
        [week, direct_confirmed, direct_logged_in,  direct_first_battle, direct_first_upgrade, direct_tank_purchase,
               ads_confirmed, ads_logged_in, ads_first_battle,
               ads_first_upgrade, ads_tank_purchase]
      end

      data = {:ads => [], :direct => []}
      results.each do |line|

        dir_confirmed = line.direct_confirmed.gsub(/ /, '').to_i
        attrs = { :type => 'Direct',
                  :confirmed => dir_confirmed}


        data[:direct] << {:week => line.week,
                           :confirmed => line.direct_confirmed.gsub(/ /, ''),
                           :logged_in => calculate_number(dir_confirmed, line.direct_logged_in),
                           :first_battle => calculate_number(dir_confirmed, line.direct_first_battle),
                           :first_upgrade => calculate_number(dir_confirmed, line.direct_first_upgrade),
                           :tank_purchase => calculate_number(dir_confirmed,line.direct_tank_purchase)}

         ads_confirmed = line.ads_confirmed.gsub(/ /, '').to_i
         data[:ads] << {:week => line.week,
                        :confirmed => line.ads_confirmed.gsub(/ /, ''),
                        :logged_in => calculate_number(ads_confirmed,line.ads_logged_in)}
        #,
        #                :first_battle =>calculate_number(ads_confirmed,line.ads_first_battle),
        #                :first_upgrade =>calculate_number(ads_confirmed,line.ads_first_upgrade),
        #                :tank_purchase =>line.ads_tank_purchase}
      end

      data
  end

  def process_file
    unless params[:data_file].nil?
      begin
        Wot::ProcessFile.process("public/data/"+ Base64.decode64(params[:data_file]))
        flash[:notice] = "Your data file is saved"
        redirect_to funnels_path
      rescue Exception => e
        flash[:error] = e.message
        redirect_to funnels_path
      end
    else
      flash[:error] = "An unexpected error occurred, please try again"
      redirect_to funnels_path
    end
  end

  private
  def calculate_number(confirmed, percentage)
    if confirmed && percentage
      ((confirmed * percentage)/100).round
    end
  end
end
