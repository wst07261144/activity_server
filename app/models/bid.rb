class Bid < ActiveRecord::Base
  def self.synchronous_bids(user,bids)
    if !Bid.all.where(:user => user).nil?
      Bid.delete_all(:user => user)
    end
    bids.each do |bid|
      Bid.create(bid)
    end
  end

  def self.update_bid(bid)
    if bid[:phone] !=Bid.last[:phone]|| bid[:bid_name] !=Bid.last[:bid_name]
      Bid.create(bid)
    end
  end
end