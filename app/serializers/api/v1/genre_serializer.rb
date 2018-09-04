class Api::V1::GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :number_of_movies

  def number_of_movies
    object.movies.size
  end
end