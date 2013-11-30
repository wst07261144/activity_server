class UserController < ApplicationController

  def login
  end

  def handle_login
    p params
    username = params[:user][:name]
    password = params[:user][:password]
    @user = User.find_by_name_and_password username,password
    if !@user.nil?
      redirect_to '/user/login_success'
      #redirect_to  user_login_success_path
      session[:user]   =  @user
    else
      @error = '用户名或者密码不正确'
      render 'login'
    end
  end

  def logout
  end

  def register
  end

  def login_success
    @user = session[:user]
  end

  def reset_key
  end

  private
  def user_params
    params.require(:user).permit(:name,  :password  )
  end
end
