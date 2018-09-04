class Api::V1::MoviesController < Api::V1::ApplicationController
  before_action :include_genre

  def index
    @movies = Movie.all

    render json: @movies, include_genre: @include_genre
  end

  def show
    @movie = Movie.find(params[:id])

    render json: @movie, include_genre: @include_genre
  end

  private
  def include_genre
    @include_genre = params['include_genre']
  end
end