class Student < ActiveRecord::Base
  has_many :assignments
  has_many :courses, through: :assignments
  has_many :categories, through: :assignments

  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |student|
      student.name = auth.info.name
      student.email = auth.info.email
      student.password = SecureRandom.hex
    end
  end
end
