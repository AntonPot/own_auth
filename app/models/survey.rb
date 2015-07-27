class Survey < ActiveRecord::Base
  has_many :opinions, dependent: :delete_all
  has_many :users, through: :opinions
end
