class SessionsController < ApplicationController
  def login
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

end
