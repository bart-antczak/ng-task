require 'net/http'
require 'json'

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @title = Movie.find(params[:id]).title
    url = "https://pairguru-api.herokuapp.com/api/v1/movies/" + @title + ""
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @res = JSON.parse(response)
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
end
