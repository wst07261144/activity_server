module ShowsHelper
  def get_bid_status(status)
    if status.empty?
      return 'ran'
    end
    return status.last[:status]
  end

  def get_num_according_price(bid_details)
    bid_count = bid_details.group(:price)
    bid_count.each do |t|
      t[:status] = bid_details.where(:price => t.price).length
    end
    return bid_count
  end

end
