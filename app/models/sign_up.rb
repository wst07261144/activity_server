class SignUp < ActiveRecord::Base
  def self.synchronous_sign_ups(params)
    if !SignUp.all.where(:user => params[:sync_data][:user]).nil?
      SignUp.delete_all(:user => params[:sync_data][:user])
    end
    params[:sync_data][:sign_ups].each do |t|
      SignUp.create(t)
    end
  end

  def self.update_sign_up(params)
    SignUp.create(params[:update_sign_up].permit!)
  end
end
