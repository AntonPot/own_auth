class Survey < ActiveRecord::Base
  has_many :opinion
  has_many :users, through: :opinion
end
