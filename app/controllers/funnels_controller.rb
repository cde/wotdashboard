require 'wot/process_file'
require "base64"

class FunnelsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def add_files
    unless params[:funnels].nil?
      begin
        uploader = DataUploader.new
        uploader.store!(params[:funnels][:file])
        @preview = Wot::ProcessFile.get_preview(params[:funnels][:file].tempfile)
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

end
