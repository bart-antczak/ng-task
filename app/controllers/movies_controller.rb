require 'net/http'
require 'json'

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @title = Movie.find(params[:id]).title.gsub(/ /, '%20')
    url_data = "https://pairguru-api.herokuapp.com/api/v1/movies/" + @title + ""
    uri_data = URI(url_data)
    response_data = Net::HTTP.get(uri_data)
    @res_data = JSON.parse(response_data)
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  def api_index
    @movies = Movie.all
  end

  def api_show
    @movie = Movie.find(params[:id])
  end

end
