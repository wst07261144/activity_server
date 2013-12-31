class SignUp < ActiveRecord::Base
  def self.synchronous_sign_ups(params)
    if !SignUp.all.where(:user=>params[:sync_data][:user]).nil?
      SignUp.delete_all(:user=>params[:sync_data][:user])
    end
    params[:sync_data][:sign_ups].each do |t|
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
