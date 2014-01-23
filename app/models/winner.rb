class Winner < ActiveRecord::Base
  def self.synchronous_winners(user,winners)
    if !Winner.all.where(:user =>user).nil?
      Winner.delete_all(:user => user)
    end
    winners.each do |winner|
      Winner.create(winner)
    end
  end

  def self.update_winner(winner)
    if winner!=nil
      win = Winner.find_by_activity_id_and_bid_name winner[:activity_id],winner[:bid_name]
      if win==nil
        Winner.create(winner)
        bid = Bid.last
        bid[:status] = 'ran'
        bid.save()
      end
    end
  end
end
