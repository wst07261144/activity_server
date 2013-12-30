class AdminsController < ApplicationController

  include UserHelper
  before_action :check_login, only:[:add_account,:manage_index,:delete_account,:admin_modify_account_key]

  def add_account
    @name = User.find(session[:current_user_id])[:name]
    @user = User.new
  end

  def manage_index
    @name = User.find(session[:current_user_id])[:name]
    @counter = set_page
    @users = User.paginate(page: params[:page], per_page: 10).where(:admin => 'false')
  end

  def admin_modify_account_key
    @new_user = User.new
    @name = User.find(session[:current_user_id])[:name]
    session[:name]= @name
    @name=User.find(params[:id]).name
  end

  def delete_account
    User.find(params[:id]).destroy
    redirect_to manage_index_path
  end

  def admin_scan
    @user = User.find_by_name params[:name]
    session[:current_user_id] = @user[:id]
    session[:admin?] = 'true'
    redirect_to '/shows/show'
  end

  def admin_modify_key
    @user = User.find_by_name session[:name]
    if @user!=nil
      update_session(@user)
      @user.destroy
    end
    @new_user = User.new(get_params(params))
    if @new_user.save
      redirect_to '/manage_index'
    else
      @name=session[:account]
      render "admin_modify_account_key"
    end
  end
end