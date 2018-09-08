class Api::V1::MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre

  has_one :genre do
    serializer.send(:serialization_options).fetch(:movies_per_genre)
  end

  def filter(keys)
    if @serialization_options.try(:[], :include_genre)
      keys
    else
      keys - [:genre]
    end
  end

end