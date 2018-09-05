# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  movie_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :user, presence: true
  validates :movie, presence: true, uniqueness: {scope: :user, message: 'can be commented only once'}
  validates :content, presence: true, length: {maximum: 4096}

  def can_be_destroyed_by?(user)
    user && self.user_id == user.id
  end
end
