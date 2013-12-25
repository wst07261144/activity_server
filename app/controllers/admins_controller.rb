class AdminsController < ApplicationController

  before_action :check_login, only:[:add_account,:manage_index,:delete_account,:admin_modify_account_key]

  def add_account
  end

  def manage_index
    @counter = set_page
    @user = User.find(session[:current_user_id])
    @users = User.paginate(page: params[:page], per_page: 10).where(:admin => 'false')
  end

  def admin_modify_account_key
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
    if params[:user][:password1].empty?||params[:user][:password2].empty?
      flash.now[:notice2]="请将密码填写完整"
      render 'admin_modify_account_key'
    else
      @name=User.find(params[:id]).name
      if params[:user][:password1]==params[:user][:password2]
        @user=User.find(params[:id])
        @user.password=params[:user][:password1]
        if @user.save
          #render :text=> "密码修改成功"
          redirect_to '/manage_index'
        end
      else
        flash.now[:notice1]="两次密码输入不一致，请重新输入"
        render "admin_modify_account_key"
      end
    end
  end
end
