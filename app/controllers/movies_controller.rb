class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.includes(:comments).find(params[:id]).decorate
    @comments = @movie.comments
    @comment = Comment.new
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back(fallback_location: root_path, notice: "Email with movie info is being sent")
  end

  def export
    MovieExporterJob.perform_later(current_user)

    redirect_to root_path, notice: "Movies are being exported"
  end
end
