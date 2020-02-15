class Category < ActiveRecord::Base
  has_many :assignments
  has_many :students, through: :assignments

  validates :title, presence: true
end
