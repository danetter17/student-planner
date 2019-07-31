class Student < ActiveRecord::Base
  has_many :subjects
  has_many :assignments, through: :subjects
end
