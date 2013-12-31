class Winner < ActiveRecord::Base
  def self.synchronous_winners(params)
    if !Winner.all.where(:user => params[:sync_data][:user]).nil?
      Winner.delete_all(:user => params[:sync_data][:user])
    end
    params[:sync_data][:winners].each do |t|
      Winner.create(t)
    end
  end

  def self.update_winner(params)
    if params[:update_data][:winner]!=nil
      win = Winner.find_by_activity_id_and_bid_name params[:update_data][:winner][:activity_id], params[:update_data][:winner][:bid_name]
      if win==nil
        Winner.create(params[:update_data][:winner].permit!)
        bid = Bid.last
        bid[:status] = 'ran'
        bid.save()
      end
    end
  end
end
