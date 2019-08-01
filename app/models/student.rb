class Student < ActiveRecord::Base
  has_many :assignments
  has_many :courses, through: :assignments
end
