class Category < ActiveRecord::Base
  has_many :assignments

  validates :title, presence: true
end
