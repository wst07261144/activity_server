class BidList < ActiveRecord::Base
  def self.synchronous_bidlists(user,bid_lists)
    if !BidList.all.where(:user => user).nil?
      BidList.delete_all(:user => user)
    end
    bid_lists.each do |bid_list|
      BidList.create(bid_list)
    end
  end

  def self.update_bidlist(bid_list)
    if bid_list[:activity_id] !=BidList.last[:activity_id]|| bid_list[:name] !=BidList.last[:name]
      BidList.create(bid_list)
    end
  end
end
