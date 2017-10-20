class User < ActiveRecord::Base
  has_secure_password

  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking, through: :likes, source: :idea

  email_validate = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :alias, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: email_validate}

  before_save :downcase_email
  
  def downcase_email
      self.email.downcase!
  end
end
