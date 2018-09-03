class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    api_movie_data[:poster] || ActionController::Base.helpers.image_path('no-image.jpg')
  end

  def rating
    "Rating #{api_movie_data[:rating]} / 10"
  end

  def plot
    api_movie_data[:plot]
  end

end
