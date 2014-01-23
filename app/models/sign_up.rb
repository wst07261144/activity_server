class SignUp < ActiveRecord::Base
  def self.synchronous_sign_ups(user,sign_ups)
    if !SignUp.all.where(:user => user).nil?
      SignUp.delete_all(:user => user)
    end
    sign_ups.each do |sign_up|
      SignUp.create(sign_up)
    end
  end

  def self.update_sign_up(sign_up)
    SignUp.create(sign_up)
  end
end
