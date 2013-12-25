class Bid < ActiveRecord::Base
  def self.synchronous_bids(params)
    if !Bid.all.where(:user=>params[:_json][0][0][:user]).nil?
      Bid.delete_all( :user=>params[:_json][0][0][:user])
    end
    params[:_json][2].each do |t|
      Bid.create(t)
    end
  end
end
