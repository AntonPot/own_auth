class Survey < ActiveRecord::Base
  has_many :options
  has_many :users, through: :options
end
