require 'pry'

class UrlsController < ApplicationController

  before_action :get_url, only: [:show, :destroy]

  def index
    @urls = Url.all
  end

  def create
    @url = Url.new(url_params)
    respond_to do |format|
      if @url.save
        # binding.pry
        format.html { redirect_to urls_path, notice: 'Url was successfully created.' }
      else
        format.html { render :new, notice: "Url could not be created" }
      end
    end
  end

  def new
    @url = Url.new
  end

  def destroy
    @url.destroy
    redirect_to_index
  end

  def expand_link
    @url = Url.find_by unique_key: params[:unique_key]
    redirect_to_url
  end

  def redirect_to_index
    redirect_to urls_path
  end

  def redirect_to_url
    @url.click_count += 1
    @url.save
    redirect_to @url.address
  end

  def get_url
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:address)
  end
end
