class Api::V1::MoviesController < Api::V1::ApplicationController
  before_action :include_genre

  def index
    @movies = Movie.includes(:genre).all

    render json: @movies, include_genre: @include_genre, movies_per_genre: movies_per_genre
  end

  def show
    @movie = Movie.find(params[:id])

    render json: @movie, include_genre: @include_genre, movies_per_genre: movies_per_genre
  end

  private
  def include_genre
    @include_genre = ! request.path.index('movies_with_genre').nil?
  end

  def movies_per_genre
    return {} unless @include_genre
    Genre.movies_per_genre
  end
end