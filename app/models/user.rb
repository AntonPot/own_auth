class User < ActiveRecord::Base
  has_secure_password
  has_many :opinions
  has_many :surveys, through: :opinions
end
