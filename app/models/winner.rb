class Winner < ActiveRecord::Base
  def self.synchronous_winners(params)
    if !Winner.all.where(:user=>params[:sync_data][:user]).nil?
      Winner.delete_all(:user=> params[:sync_data][:user])
    end
    params[:sync_data][:winners].each do |t|
      Winner.create(t)
    end
  end

  def self.update_winner(params)
    if params[:_json][2]!=nil
      @win = Winner.find_by_activity_id_and_bid_name params[:_json][2][:activity_id],params[:_json][2][:bid_name]
      if @win==nil
        Winner.create(params[:_json][2])
        @bid = Bid.last
        @bid[:status] = 'ran'
        @bid.save()
      end
    end
  end

end
