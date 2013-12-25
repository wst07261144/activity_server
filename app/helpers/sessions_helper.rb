module SessionsHelper
  def sign_up(user)
    if user.name=='admin'
      return redirect_to '/manage_index'
    end
    redirect_to '/shows/show'
  end

  def sign_in(user)
    if user.name!="admin"
      session[:current_user_id] = user.id
      redirect_to '/shows/show'
    else
      session[:current_user_id] = user.id
      redirect_to '/manage_index'
    end
  end

  def check_synchronous_success(params)
    current_user = params[:_json][0][0][:user]
    if params[:_json][0].length == Activity.all.where(:user=>current_user).length&&
        params[:_json][1].length == SignUp.all.where(:user=>current_user).length&&
        params[:_json][2].length == Bid.all.where(:user=>current_user).length&&
        params[:_json][3].length == BidList.all.where(:user=>current_user).length&&
        params[:_json][4].length == Winner.all.where(:user=>current_user).length
      return 'true'
    end
  end

end
