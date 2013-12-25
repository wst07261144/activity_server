class Activity < ActiveRecord::Base
  def self.synchronous_activities(params)
    if  !Activity.all.where(:user=>params[:_json][0][0][:user]).nil?
      Activity.delete_all(:user=> params[:_json][0][0][:user])
    end
    params[:_json][0].each do |t|
      Activity.create(t)
    end
  end
end
