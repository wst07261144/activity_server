class UserController < ApplicationController

  before_action :check_login ,only: [:admin_create]

  def register
    @user = User.new
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
         redirect_to root_path
       end
    else
      flash.now[:notice6]='两次密码输入不一致，请重新输入'
      render "reset_key3_to_reset_key"
    end
  end

  def handle_reset_key2
    @question = session[:question]
    if session[:answer]==params[:user][:answer]
      redirect_to '/reset_key3_to_reset_key'
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
      redirect_to '/reset_key2_check_question'
    else
      flash.now[:notice4]='该账户名不存在'
      render "reset_key1_check_account"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id]= @user.id
      redirect_to '/shows/show'
    else
      render 'register'
    end
  end

  def admin_create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id]= @user.id
      redirect_to '/shows/show'
    else
      render 'register'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :question, :answer)
  end
end