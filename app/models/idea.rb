class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :likers, through: :likes, source: :user

  validates :content, length: {minimum: 5}, presence: true
end
