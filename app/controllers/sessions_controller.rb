class SessionsController < ApplicationController

  include SessionsHelper
  skip_before_filter :verify_authenticity_token,:process_clients_login,:process_synchronous

  def login
    if session[:current_user_id]!=nil
      @user = User.find(session[:current_user_id])
      sign_up(@user)
    end
  end

  def create
    @user = User.find_by_name_and_password params[:session][:name], params[:session][:password]
    if !@user.nil?
      sign_in(@user)
    else
      flash.now[:notice]= '用户名或者密码不正确'
      render '/sessions/login'
    end
  end

  def logout
    session[:current_user_id] = nil
    session[:admin?] = nil
    redirect_to root_path
  end

  def process_clients_login
    @user = User.find_by_name_and_password params[:account], params[:key]
    respond_to do |format|
      if @user.nil?
        format.json { render json: '帐号名或密码错误'}
      else
        format.json { render json: '登录成功'}
      end
    end
  end

  def process_synchronous
    Activity.synchronous_activities(params)
    SignUp.synchronous_sign_ups(params)
    Bid.synchronous_bids(params)
    BidList.synchronous_bidlists(params)
    Winner.synchronous_winners(params)
    respond_to do |format|
      if check_synchronous_success(params)=='true'
        format.json { render json: '同步成功'}
      else
        format.json { render json: '同步失败，请重新同步'}
      end
    end
  end

  def activity_save_activity
    if params[:id]!=Activity.last[:activity_id]
      Activity.create(:activity_id=>params[:id],:name=>params[:name],:user=>params[:user])
    end
    redirect_to '/shows/show'
  end

  def save_sign_up
    sign_up= SignUp.where(:activity_id =>params[:activity_id])
    if  sign_up.empty?
      SignUp.create(:name=>params[:name],:phone=>params[:phone],:activity_id=>params[:activity_id],:user=>params[:user])
    else
      if sign_up.last[:phone]!=params[:phone]
        SignUp.create(:name=>params[:name],:phone=>params[:phone],:activity_id=>params[:activity_id],:user=>params[:user])
      end
    end
    redirect_to '/shows/show'
  end

  def activity_save
    if params.length!=2
      if params[:_json][0][:phone]!=nil
        if params[:_json][0][:phone] !=Bid.last[:phone]||params[:_json][0][:bid_name] !=Bid.last[:bid_name]
          Bid.create(params[:_json][0])
        end
      end
      if params[:_json][1][:activity_id] !=BidList.last[:activity_id]||
          params[:_json][1][:name] !=BidList.last[:name]
        BidList.create(params[:_json][1])
      end
      if params[:_json][2]!=nil
        @win = Winner.find_by_activity_id_and_bid_name params[:_json][2][:activity_id],params[:_json][2][:bid_name]
        if @win==nil
          Winner.create(params[:_json][2])
          @bid = Bid.last
          @bid[:status] = 'ran'
          @bid.save()
        end
      end
    end
    redirect_to '/shows/activity_show'
  end

end