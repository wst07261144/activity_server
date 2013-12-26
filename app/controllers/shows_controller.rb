class ShowsController < ApplicationController

  include ShowsHelper
  before_action :check_login, only:[:show,:bid_list,:sign_up_list,:bid_detail]

  def activity_show
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @name = Activity.where(:user=>@users[:name]).last[:name]
    @bidlist = BidList.where(:user=>@users[:name]).last
    @win = Winner.where(:user=>@users[:name]).last
    @bidding_detail = Bid.paginate(page: params[:page], per_page: 10).where(:activity_id=>@bidlist[:activity_id],:bid_name=>@bidlist[:name]).order(:created_at, created_at: :desc)
    @num = SignUp.all.where(:activity_id=>@bidlist[:activity_id])
    if @win!=nil
      if @win[:activity_id]== @bidlist[:activity_id]&&@win[:bid_name]== @bidlist[:name]
        @bidding_detail = Bidding.all
        if @win[:name]=='竞价无效'
          flash.now[:notice1]='本次竞价无效'
        else
          flash.now[:notice2]='获胜者:'+@win[:name]
          flash.now[:notice3]='出价:'+@win[:price]+'元'
          flash.now[:notice4]='手机号:'+@win[:phone]
        end
      else
        @xingming='姓名'
        @phone='电话'
        flash.now[:notice5]='参与人数:'
        flash.now[:notice6]='('+ @bidding_detail.length.to_s + '/' + @num.length.to_s + ')'
      end
    else
      @xingming='姓名'
      @phone='电话'
      flash.now[:notice5]='参与人数:'
      flash.now[:notice6]='('+ @bidding_detail.length.to_s + '/' + @num.length.to_s + ')'
    end
    @bidding_details=@bidding_detail
  end

  def bid_detail
    @counter = set_page
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @bid = params[:name]
    @win = Winner.find_by_activity_id_and_bid_name params[:activity_id],params[:name]
    if @win.nil?
      flash.now[:notice0]='活动正在进行中...'
    else
      if@win[:name]=='竞价无效'
        flash.now[:notice1]='本次竞价无效'
      else
        flash.now[:notice2]='获胜者:'+@win.name
        flash.now[:notice3]='出价:'+@win.price+'元'
        flash.now[:notice4]='手机号:'+@win.phone
      end
    end
    @bid_details = Bid.paginate(page: params[:page], per_page: 10).where(:user=>@users.name,:activity_id=>params[:activity_id],:bid_name=>params[:name]).order(:price, created_at: :desc)
    bid_count = @bid_details.group(:price)
    bid_count.each do|t|
      t[:status] = bid_count.where(:price=>t.price).length
    end
    @bid_counts=bid_count
  end

  def bid_list
    @counter = set_page
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @bid_lists = BidList.paginate(page: params[:page], per_page: 10).where(:user=>@users.name,:activity_id=>params[:activity_id])
  end

  def show
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @counter = set_page
    @activities = Activity.paginate(page: params[:page], per_page: 10).where(:user=>@users.name)
    @bid_status = Bid.all.where(:user=>@users[:name])
    @status= get_bid_status(@bid_status)
  end

  def sign_up_list
    @counter = set_page
    @user = check_admin
    @users = User.find(session[:current_user_id])
    @sign_ups = SignUp.paginate(page: params[:page], per_page: 10).where(:user=>@users.name,:activity_id=>params[:activity_id])
  end

  private
  def check_admin
    if session[:admin?]=='true'
      return User.find(1)
    end
    return User.find(session[:current_user_id])
  end

end
