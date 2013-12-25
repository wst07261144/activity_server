class AdminsController < ApplicationController

  def add_account
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path
    end
  end

  def manage_index
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path   t
    else
      @counter = set_page
      @user = User.find(session[:current_user_id])
      @users = User.paginate(page: params[:page], per_page: 10).where(:admin => 'false')
    end
  end

  def delete_account
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path
    else
      User.find(params[:id]).destroy
      redirect_to manage_index_path
    end
  end

  def admin_scan
    params[:name]
    @user = User.find_by_name params[:name]
    session[:current_user_id] = @user[:id]
    redirect_to '/shows/show'
  end

  def admin_modify_account_key
    @name=User.find(params[:id]).name
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path
    end
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
