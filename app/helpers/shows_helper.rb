module ShowsHelper
  def get_bid_status(status)
    if status.empty?
      return 'ran'
    end
    return status.last[:status]
  end

end
