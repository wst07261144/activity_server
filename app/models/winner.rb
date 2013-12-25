class Winner < ActiveRecord::Base
  def self.synchronous_winners(params)
    if !Winner.all.where(:user=>params[:_json][0][0][:user]).nil?
      Winner.delete_all(:user=> params[:_json][0][0][:user])
    end
    params[:_json][4].each do |t|
      Winner.create(t)
    end
  end

end
