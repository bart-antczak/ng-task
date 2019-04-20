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
    @comments = Comment.where(movie_id: params[:id])
    @comment = Comment.new
    @res_data = JSON.parse(response_data)
  end

  def send_info
    @movie = Movie.find(params[:id])
    EmailDetailsJob.perform_later(current_user, @movie)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    ExportMoviesJob.perform_later(current_user)
    redirect_to root_path, notice: "Movies exported"
  end

  def api_index
    @movies = Movie.all
  end

  def api_show
    @movie = Movie.find(params[:id])
  end

end
