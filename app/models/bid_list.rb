class BidList < ActiveRecord::Base
  def self.synchronous_bidlists(params)
    if !BidList.all.where(:user=>params[:_json][0][0][:user]).nil?
      BidList.delete_all(:user=> params[:_json][0][0][:user])
    end
    params[:_json][3].each do |t|
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
