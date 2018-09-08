# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Genre < ApplicationRecord
  has_many :movies

  def self.movies_per_genre
    Movie.group(:genre_id).count
  end
end
