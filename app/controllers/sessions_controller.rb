class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :process_clients_login, :process_synchronous

  def login
    if session[:current_user_id]!=nil
      @user = User.find(session[:current_user_id])
      sign_up(@user)
    end
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      sign_in(@user)
    else
      @err = 'true'
      render '/sessions/login'
    end
  end

  def logout
    session[:current_user_id] = nil
    session[:admin?] = nil
    redirect_to root_path
  end

  def process_clients_login
    @user = User.find_by(name: params[:account])
    respond_to do |format|
    if @user && @user.authenticate( params[:key])
      format.json { render json: 'true' }
    else
      format.json { render json: 'false' }
     end
    end
  end

  def process_synchronous
    Activity.synchronous_activities(params[:sync_data][:user],params[:sync_data][:activities])
    SignUp.synchronous_sign_ups(params[:sync_data][:user],params[:sync_data][:sign_ups])
    Bid.synchronous_bids(params[:sync_data][:user],params[:sync_data][:bids])
    BidList.synchronous_bidlists(params[:sync_data][:user],params[:sync_data][:bid_lists])
    Winner.synchronous_winners(params[:sync_data][:user],params[:sync_data][:winners])
    respond_to do |format|
      if check_synchronous_success(params)=='true'
        format.json { render json: 'true' }
      else
        format.json { render json: 'false' }
      end
    end

  end

  def save_activity
    Activity.update_activity(params[:update_activity][:id],params[:update_activity][:name],params[:update_activity][:user])
    redirect_to '/shows/show'
  end

  def save_sign_up
    sign_up= SignUp.where(:activity_id => params[:update_sign_up][:activity_id])
    if  sign_up.empty?||SignUp.where(:activity_id =>params[:update_sign_up][:activity_id]).last[:phone]!=params[:update_sign_up][:phone]
      SignUp.update_sign_up(params[:update_sign_up].permit!)
    end
    redirect_to '/shows/show'
  end

  def save_bid
    if params.length!=2
      if params[:update_data][:bid][:phone]!=nil
        Bid.update_bid(params[:update_data][:bid].permit!)
      end
      BidList.update_bidlist(params[:update_data][:bid_list].permit!)
      if params[:update_data][:winner].present?
        Winner.update_winner(params[:update_data][:winner].permit!)
      end
    end
    redirect_to '/shows/show'
  end

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
    current_user = params[:sync_data][:user]
    if params[:sync_data][:activities].length == Activity.all.where(:user=>current_user).length&&
        params[:sync_data][:sign_ups].length == SignUp.all.where(:user=>current_user).length&&
        params[:sync_data][:bids].length == Bid.all.where(:user=>current_user).length&&
        params[:sync_data][:bid_lists].length == BidList.all.where(:user=>current_user).length&&
        params[:sync_data][:winners].length == Winner.all.where(:user=>current_user).length
      return 'true'
    end
  end
end