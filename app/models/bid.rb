class Bid < ActiveRecord::Base
  def self.synchronous_bids(params)
    if !Bid.all.where(:user=>params[:sync_data][:user]).nil?
      Bid.delete_all(:user=>params[:sync_data][:user])
    end
    params[:sync_data][:bids].each do |t|
      Bid.create(t)
    end
  end

  def self.update_bid(params)
    if params[:_json][0][:phone] !=Bid.last[:phone]||params[:_json][0][:bid_name] !=Bid.last[:bid_name]
      Bid.create(params[:_json][0])
    end
  end

end
