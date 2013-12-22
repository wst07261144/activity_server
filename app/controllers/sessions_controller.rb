class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token,:process_clients_login,:process_synchronous

  def login
  end

  def judge_login_or_show
    if session[:current_user_id].nil?
      render 'login'
    else
      @user = User.find(session[:current_user_id])
      if @user.name=='admin'
        redirect_to '/manage_index'
      else
        render 'show'
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
        redirect_to '/sessions/show'
      else
        session[:current_user_id] = @user.id
        redirect_to '/manage_index'
      end
    else
      flash.now[:notice]= '用户名或者密码不正确'
      render 'login'
    end
  end

  def logout
    user = User.find(session[:current_user_id])
    session[:current_user_id] = nil
    session[:current_user_of_admin] = nil
    redirect_to root_path
  end

  def show
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to 'login'
    else
      @user = User.find(session[:current_user_id])
      if session[:current_user_of_admin] == 'admin'
        @user1 ='admin'
        flash.now[:notice]='、'
      end
      if params[:page]==nil||params[:page]==1
        counter = 1
      else
        counter = (params[:page].to_i-1)*10+1
      end
      @counter = counter
      @activities = Activity.paginate(page: params[:page], per_page: 10).where(:user=>@user.name)
    end
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

  def bid_list
    if session[:current_user_id].nil?
      render 'login'
    else
      if params[:page]=='1' ||params[:page]==nil
        counter =1
      else
        counter = (params[:page].to_i-1)*10+1
      end
      if session[:current_user_of_admin] == 'admin'
        @user1 ='admin'
        flash.now[:notice]='、'
      end
      @counter = counter
      @user = User.find(session[:current_user_id])
      @bid_lists = BidList.paginate(page: params[:page], per_page: 10).where(:user=>@user.name,:activity_id=>params[:activity_id])

    end
  end

  def sign_up_list
    if session[:current_user_id].nil?
      render 'login'
    else
      if params[:page]=='1' ||params[:page]==nil
        counter =1
      else
        counter = (params[:page].to_i-1)*10+1
      end
      if session[:current_user_of_admin] == 'admin'
        @user1 ='admin'
        flash.now[:notice]='、'
      end
      @counter = counter
      @user = User.find(session[:current_user_id])
      @sign_ups = SignUp.paginate(page: params[:page], per_page: 10).where(:user=>@user.name,:activity_id=>params[:activity_id])

    end
  end

  def bid_detail
    if session[:current_user_id].nil?
      render 'login'
    else
      if params[:page]=='1' ||params[:page]==nil
        counter =1
      else
        counter = (params[:page].to_i-1)*10+1
      end
      if session[:current_user_of_admin] == 'admin'
        @user1 ='admin'
        flash.now[:notice]='、'
      end
      @counter = counter
      @bid = params[:name]
      @user = User.find(session[:current_user_id])
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
      @bid_details = Bid.paginate(page: params[:page], per_page: 10).where(:user=>@user.name,:activity_id=>params[:activity_id],:bid_name=>params[:name]).order(:price, created_at: :desc)
      bid_count = @bid_details.group(:price)
      bid_count.each do|t|
        t[:status] = bid_count.where(:price=>t.price).length
      end
      @bid_counts=bid_count
    end
  end

  def activity_show
    p params
    @name_ = Activity.find_by_activity_id  session[:activity_id1]
    @name = @name_[:name]
    @win = Winner.find_by_activity_id_and_bid_name session[:activity_id1],session[:bid_name]
    @bidding_detail = Bid.paginate(page: params[:page], per_page: 10).where(:activity_id=>session[:activity_id1],:bid_name=>session[:bid_name]).order(:created_at, created_at: :desc)
    @num = SignUp.all.where(:activity_id=>session[:activity_id1])
    if @win==nil
      @xingming='姓名'
      @phone='电话'
      flash.now[:notice5]='参与人数:'
      flash.now[:notice6]='('+ @bidding_detail.length.to_s + '/' + @num.length.to_s + ')'
    else
      @class = nil
      @bidding_detail = Bidding.all
      if @win[:name]=='竞价无效'
        flash.now[:notice1]='本次竞价无效'
      else
        flash.now[:notice2]='获胜者:'+@win[:name]
        flash.now[:notice3]='出价:'+@win[:price]+'元'
        flash.now[:notice4]='手机号:'+@win[:phone]
      end
    end
    @bidding_details = @bidding_detail
  end
  def activity_save
    if params.length!=2
      session[:activity_id1]= params[:_json][0][:activity_id]
      session[:bid_name]= params[:_json][0][:bid_name]
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
    redirect_to '/sessions/activity_show'
  end
end