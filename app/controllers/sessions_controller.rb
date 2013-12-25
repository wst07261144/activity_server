class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token,:process_clients_login,:process_synchronous

  def login
    if session[:current_user_id].nil?
      render
    else
      @user = User.find(session[:current_user_id])
      if @user.name=='admin'
        redirect_to '/manage_index'
      else
        redirect_to '/shows/show'
      end
    end
  end

  def create
    username = params[:session][:name]
    password = params[:session][:password]
    @user = User.find_by_name_and_password username, password
    if !@user.nil?
      if @user.name!="admin"
        session[:current_user_id] = @user.id
        redirect_to '/shows/show'
      else
        session[:current_user_id] = @user.id
        redirect_to '/manage_index'
      end
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
    current_user = params[:_json][0][0][:user]
    if  !Activity.all.where(:user=>current_user).nil?
      Activity.delete_all(:user=> current_user)
    end
    if !SignUp.all.where(:user=>current_user).nil?
      SignUp.delete_all(:user=>current_user)
    end
    if !Bid.all.where(:user=>current_user).nil?
      Bid.delete_all( :user=>current_user)
    end
    if !BidList.all.where(:user=>current_user).nil?
      BidList.delete_all(:user=> current_user)
    end
    if !Winner.all.where(:user=>current_user).nil?
      Winner.delete_all(:user=> current_user)
    end
    params[:_json][0].each do |t|
      Activity.create(t)
    end
    params[:_json][1].each do |t|
      SignUp.create(t)
    end
    params[:_json][2].each do |t|
      Bid.create(t)
    end
    params[:_json][3].each do |t|
      BidList.create(t)
    end
    params[:_json][4].each do |t|
      Winner.create(t)
    end
    activity = Activity.all.where(:user=>current_user)
    sign_up = SignUp.all.where(:user=>current_user)
    bid  = Bid.all.where(:user=>current_user)
    bid_list  = BidList.all.where(:user=>current_user)
    winner  = Winner.all.where(:user=>current_user)
    respond_to do |format|
      if params[:_json][0].length == activity.length&&
          params[:_json][1].length == sign_up.length&&
          params[:_json][2].length == bid.length&&
          params[:_json][3].length == bid_list.length&&
          params[:_json][4].length == winner.length
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