class Activity < ActiveRecord::Base
  def self.synchronous_activities(params)
    if  !Activity.all.where(:user => params[:sync_data][:user]).nil?
      Activity.delete_all(:user => params[:sync_data][:user])
    end
    params[:sync_data][:activities].each do |t|
      Activity.create(t)
    end
  end

  def self.update_activity(params)
    if params[:update_activity][:id]!=Activity.last[:activity_id]
      Activity.create(:activity_id => params[:update_activity][:id], :name => params[:update_activity][:name], :user => params[:update_activity][:user])
    end
  end
end
