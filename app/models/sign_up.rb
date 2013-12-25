class SignUp < ActiveRecord::Base
  def self.synchronous_sign_ups(params)
    if !SignUp.all.where(:user=>params[:_json][0][0][:user]).nil?
      SignUp.delete_all(:user=>params[:_json][0][0][:user])
    end
    params[:_json][1].each do |t|
      SignUp.create(t)
    end
  end
end
