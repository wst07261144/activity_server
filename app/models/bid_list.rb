class BidList < ActiveRecord::Base
  def self.synchronous_bidlists(params)
    if !BidList.all.where(:user=>params[:sync_data][:user]).nil?
      BidList.delete_all(:user=> params[:sync_data][:user])
    end
    params[:sync_data][:bid_lists].each do |t|
      BidList.create(t)
    end
  end

  def self.update_bidlist(params)
    if params[:_json][1][:activity_id] !=BidList.last[:activity_id]||
        params[:_json][1][:name] !=BidList.last[:name]
       BidList.create(params[:_json][1])
    end
  end
end
