class UserController < ApplicationController
  # include UserHelper
  def login
  end

  def logout
  end

  def register
  end

  def manage_index
    @user = User.paginate(page: params[:page], per_page: 9).where(:admin => 'false')
  end

  def reset_key1_check_account
  end

  def reset_key2_check_question
    @question = session[:question]
  end

  def reset_key3_to_reset_key
  end

  def handle_reset_key3
    if params[:user][:password1]==params[:user][:password2]
       @user=User.find_by_name session[:account]
       @user.password= params[:user][:password1]
       if @user.save
         redirect_to '/user/login'
       end
    else
      flash.now[:notice6]='两次密码输入不一致，请重新输入'
      render "reset_key3_to_reset_key"
    end
  end

  def handle_reset_key2
    @question = session[:question]
    if session[:answer]==params[:user][:answer]
      redirect_to '/user/reset_key3_to_reset_key'
    else
      flash.now[:notice5]='忘记密码答案错误'
      render "reset_key2_check_question"
    end
  end


  def handle_reset_key1
    @user=User.find_by_name params[:user][:name]
    if @user
      session[:answer]=@user.forget_key_answer
      session[:account]= @user.name
      session[:question] = @user.forget_key_question
      redirect_to '/user/reset_key2_check_question'
    else
      flash.now[:notice4]='该账户名不存在'
      render "reset_key1_check_account"
    end
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
                  "forget_key_answer" => params[:user][:answer],
                  "admin"=>'false'}
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
      if @user.name!="admin"
        redirect_to '/user/login_success' #redirect_to  user_login_success_path
        session[:user] = @user
      else
        redirect_to '/user/manage_index'
      end
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
