class UserController < ApplicationController
  def register
  end
  def add_account
  end
  def judge_add_account
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path
    else
      render 'add_account'
    end
  end
  def reset_key1_check_account
  end
  def reset_key2_check_question
    @question = session[:question]
  end
  def reset_key3_to_reset_key
  end
  def manage_index
    if params[:page]=='1' ||params[:page]==nil
      counter =1
    else
      counter = (params[:page].to_i-1)*10+1
    end
    @counter = counter
    @user = User.find(session[:current_user_id])
    @users = User.paginate(page: params[:page], per_page: 10).where(:admin => 'false')
  end
  def admin_modify_account_key
    @name=User.find(params[:id]).name
  end

  def judge_modify_account_key
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path
    else
      @name=User.find(params[:id]).name
      render 'admin_modify_account_key'
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
  def judge_input_legal
    session[:add_or_register]="register"
    if user_params
      return judge_input_complete
    end
  end
  def judge_input_legal1
    if session[:current_user_id].nil?
      flash[:notice0]='请先登录'
      redirect_to root_path
    else
      if user_params
        return judge_input_complete1
      end
    end

  end
  def judge_input_complete1
    p params
    if params[:user][:name].empty?||params[:user][:question].empty?||
        params[:user][:answer].empty?||params[:user][:password1].empty?||
        params[:user][:password2].empty?
      flash.now[:notice1]= "请将注册信息填写完整"
      render "add_account"
    else
      return judge_key_same1
    end
  end
  def judge_key_same1
    if params[:user][:password1] != params[:user][:password2]
      flash.now[:notice2]= "两次密码输入不一致，请重新输入"
      render "add_account"
    else
      return judge_name_has_signed1
    end
  end
  def judge_name_has_signed1
    signed_name = User.find_by_name params[:user][:name]
    if !signed_name.nil?
      flash.now[:notice3]= "该账号已注册"
      render "add_account"
    else
      return admin_create
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
  def admin_create
    session[:add_or_register] = nil
    user_params_={"name" => params[:user][:name], "password" => params[:user][:password1],
                  "forget_key_question" => params[:user][:question],
                  "forget_key_answer" => params[:user][:answer],
                  "admin"=>'false'}
    @user = User.new(user_params_)
    if @user.save
      session[:user]= User.find_by_name params[:user][:name]
      redirect_to '/manage_index'
    else
      redirect_to 'http://baidu.com'
    end
  end
  def create
    user_params_={"name" => params[:user][:name], "password" => params[:user][:password1],
                  "forget_key_question" => params[:user][:question],
                  "forget_key_answer" => params[:user][:answer],
                  "admin"=>'false'}
    @user = User.new(user_params_)
    if @user.save
      session[:current_user_id]= @user.id
      redirect_to '/sessions/show'
    else
      redirect_to 'http://baidu.com'
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
  def manage_index_or_login
     if session[:current_user_id].nil?
       redirect_to '/sessions/login'
     else
       redirect_to '/manage_index'
     end
  end

  def admin_scan
    params[:name]
    @user = User.find_by_name params[:name]
    session[:current_user_id] = @user[:id]
    session[:current_user_of_admin] = 'admin'
    redirect_to '/sessions/show'

  end

  private
  def user_params
    params.require(:user).permit(:name, :password1, :password2, :question, :answer)
  end
end
