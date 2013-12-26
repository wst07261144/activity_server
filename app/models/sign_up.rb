class SignUp < ActiveRecord::Base
  def self.synchronous_sign_ups(params)
    if !SignUp.all.where(:user=>params[:_json][0][0][:user]).nil?
      SignUp.delete_all(:user=>params[:_json][0][0][:user])
    end
    params[:_json][1].each do |t|
      SignUp.create(t)
    end
  end

  def self.update_sign_up1(params)
    SignUp.create(:name=>params[:name],:phone=>params[:phone],:activity_id=>params[:activity_id],:user=>params[:user])
  end

  def self.update_sign_up2(params)
    if SignUp.where(:activity_id =>params[:activity_id]).last[:phone]!=params[:phone]
      SignUp.create(:name=>params[:name],:phone=>params[:phone],:activity_id=>params[:activity_id],:user=>params[:user])
    end
  end

end
