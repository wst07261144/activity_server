class UserController < ApplicationController

  include UserHelper
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

  def handle_reset_key1
    @user=User.find_by_name params[:user][:name]
    if @user
      update_session(@user)
      redirect_to '/reset_key2_check_question'
    else
      @err_msg = 'true'
      render "reset_key1_check_account"
    end
  end

  def handle_reset_key2
    @question = session[:question]
    if session[:answer]==params[:user][:answer]
      redirect_to '/reset_key3_to_reset_key'
    else
      @err_msg='true'
      render "reset_key2_check_question"
    end
  end

  def handle_reset_key3
    if params[:user][:password] == params[:user][:password_confirmation]
      @user=User.find_by_name session[:account]
      @user.password_digest= params[:user][:password]
      if @user.save
        redirect_to root_path
      else
        render 'reset_key3_to_reset_key'
      end
    else
      @err_msg='true'
      render "reset_key3_to_reset_key"
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