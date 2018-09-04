class Api::V1::MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre

  has_one :genre

  def filter(keys)
    if %w(1 true).include?(@serialization_options.try(:[], :include_genre))
      keys
    else
      keys - [:genre]
    end
  end

end