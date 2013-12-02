class UserController < ApplicationController
  # include UserHelper
  def login
  end

  def logout
  end

  def register
  end

  def reset_key
  end

  def login_success
    @user = session[:user]
  end

  def judge_input_legal
    if user_params
      return judge_input_complete
    end
  end

  def judge_input_complete
    p params
    if params[:user][:name].empty?||params[:user][:question].empty?||
        params[:user][:answer].empty?||params[:user][:password1].empty?||
        params[:user][:password2].empty?
      flash.now[:notice1]= "请将注册信息填写完整"
      render "register"
    else
      return judge_key_same
    end
  end

  def judge_key_same
    if params[:user][:password1] != params[:user][:password2]
      flash.now[:notice2]= "两次密码输入不一致，请重新输入"
      render "register"
    else
      return judge_name_has_signed
    end
  end

  def judge_name_has_signed
    signed_name = User.find_by_name params[:user][:name]
    if !signed_name.nil?
      flash.now[:notice3]= "该账号已注册"
      render "register"
    else
      return create
    end
  end

  def create
    user_params_={"name" => params[:user][:name], "password" => params[:user][:password1],
                  "forget_key_question" => params[:user][:question],
                  "forget_key_answer" => params[:user][:answer]}
    @user = User.new(user_params_)
    if @user.save
      session[:user]= User.find_by_name params[:user][:name]
      redirect_to '/user/login_success'
    else
      redirect_to 'http://baidu.com'
    end
  end

  def handle_login
    username = params[:user][:name]
    password = params[:user][:password]
    @user = User.find_by_name_and_password username, password
    if !@user.nil?
      redirect_to '/user/login_success' #redirect_to  user_login_success_path
      session[:user] = @user
    else
      flash.now[:notice]= '用户名或者密码不正确'
      render 'login'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password1, :password2, :question, :answer)
  end
end
