class BidList < ActiveRecord::Base
  def self.synchronous_bidlists(params)
    if !BidList.all.where(:user => params[:sync_data][:user]).nil?
      BidList.delete_all(:user => params[:sync_data][:user])
    end
    params[:sync_data][:bid_lists].each do |t|
      BidList.create(t)
    end
  end

  def self.update_bidlist(params)
    if params[:update_data][:bid_list][:activity_id] !=BidList.last[:activity_id]||
        params[:update_data][:bid_list][:name] !=BidList.last[:name]
      BidList.create(params[:update_data][:bid_list].permit!)
    end
  end
end
