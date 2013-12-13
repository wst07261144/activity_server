class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token,:only =>:process_clients_login

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
    session[:current_user_id] = nil
    redirect_to root_path
  end

  def show
    @user = User.find(session[:current_user_id])
  end

  def judge_show
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to 'login'
    else
      @user = User.find(session[:current_user_id])
      render 'show'
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
end
