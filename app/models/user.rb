class User < ActiveRecord::Base
  validates :name, presence: true ,uniqueness: { case_sensitive: false }
  validates :question, presence: true
  validates :answer, presence: true
  has_secure_password
end
