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
        funnels = Wot::ProcessFile.load_data("public/data/"+ Base64.decode64(params[:data_file]))
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


end