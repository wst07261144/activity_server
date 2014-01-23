class Activity < ActiveRecord::Base
  def self.synchronous_activities(user,activities)
    if  !Activity.all.where(:user => user).nil?
      Activity.delete_all(:user => user)
    end
    activities.each do |activity|
      Activity.create(activity)
    end
  end

  def self.update_activity(activity_id,name,user)
    if activity_id!=Activity.last[:activity_id]
      Activity.create(:activity_id =>activity_id, :name => name, :user => user)
    end
  end
end
