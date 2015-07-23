class User < ActiveRecord::Base
  has_secure_password

  has_many :opinions
  has_many :surveys, through: :opinions

  validates :email, confirmation: true # doesn't need to vaildate password confirmation, it must be added to #has_secure_password
  validates :first_name, :last_name, :email, :email_confirmation, presence: true
  validates :email, uniqueness: true

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "must be an email address" }

end
