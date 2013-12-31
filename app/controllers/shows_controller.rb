class ShowsController < ApplicationController

  before_action :check_login, only: [:show, :bid_list, :sign_up_list, :bid_detail]

  def show
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @counter = set_page
    @activities = Activity.paginate(page: params[:page], per_page: 10).where(:user => @users.name)
    @bid_status = Bid.all.where(:user => @users[:name])
    @status= get_bid_status(@bid_status)
  end

  def sign_up_list
    @counter = set_page
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @sign_ups = SignUp.paginate(page: params[:page], per_page: 10).where(:user => @users.name, :activity_id => params[:activity_id])
  end

  def bid_list
    @counter = set_page
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @bid_lists = BidList.paginate(page: params[:page], per_page: 10).where(:user => @users.name, :activity_id => params[:activity_id])
  end

  def bid_detail
    @counter = set_page
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @bid = params[:name]
    @win = Winner.find_by_activity_id_and_bid_name params[:activity_id], params[:name]
    @bid_details = Bid.paginate(page: params[:page], per_page: 10).where(:user => @users.name, :activity_id => params[:activity_id], :bid_name => params[:name]).order(price: :asc)
    @bid_counts = get_num_according_price(@bid_details)
  end

  def activity_show
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @name = Activity.where(:user => @users[:name]).last[:name]
    @bidlist = BidList.where(:user => @users[:name]).last
    @win = Winner.where(:user => @users[:name]).last
    @bidding_detail = Bid.paginate(page: params[:page], per_page: 10).where(:activity_id => @bidlist[:activity_id], :bid_name => @bidlist[:name]).order(created_at: :desc)
    @num = SignUp.all.where(:activity_id => @bidlist[:activity_id])
    if @win!=nil&&@win[:activity_id]== @bidlist[:activity_id]&&@win[:bid_name]== @bidlist[:name]
      @win[:activity_id]== @bidlist[:activity_id]&&@win[:bid_name]== @bidlist[:name]
      @bidding_detail = Bidding.all
      @win1 = 'true'
    end
    @bidding_details=@bidding_detail
  end

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

  private
  def check_admin
    if session[:admin?]=='true'
      return User.find(1)
    end
    return User.find(session[:current_user_id])
  end

end
