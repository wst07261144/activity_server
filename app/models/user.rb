class User < ActiveRecord::Base
  validates :name, presence: true ,uniqueness: { case_sensitive: false }
  validates :question, presence: true
  validates :answer, presence: true
  has_secure_password

  def self.delete_user(name)
    user = User.find_by_name name
    if user!=nil
      user.destroy
    end
  end
end
