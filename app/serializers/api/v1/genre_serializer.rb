class Api::V1::GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :number_of_movies

  def number_of_movies
    if @serialization_options.try(:[], :movies_per_genre)
      @serialization_options[:movies_per_genre][object.id] || 0
    else
      # fallback
      object.movies.size
    end
  end

end