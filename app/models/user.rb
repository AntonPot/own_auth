class User < ActiveRecord::Base
  has_secure_password

  has_many :opinions
  has_many :surveys, through: :opinions

  validates :email, :password, confirmation: true
  validates :first_name, :last_name, :username, :email, :email_confirmation, presence: true
  validates :username, uniqueness: true

  # validates :email_confirmation, presence: true
  # validates :email, confirmation: true

end
