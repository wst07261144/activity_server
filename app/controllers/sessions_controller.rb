class SessionsController < ApplicationController

  include SessionsHelper
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
    Activity.synchronous_activities(params)
    SignUp.synchronous_sign_ups(params)
    Bid.synchronous_bids(params)
    BidList.synchronous_bidlists(params)
    Winner.synchronous_winners(params)
    respond_to do |format|
      if check_synchronous_success(params)=='true'
        format.json { render json: 'true' }
      else
        format.json { render json: 'false' }
      end
    end
  end

  def save_activity
    Activity.update_activity(params)
    redirect_to '/shows/show'
  end

  def save_sign_up
    sign_up= SignUp.where(:activity_id => params[:activity_id])
    if  sign_up.empty?
      SignUp.update_sign_up1(params)
    else
      SignUp.update_sign_up2(params)
    end
    redirect_to '/shows/show'
  end

  def save_bid
    if params.length!=2
      if params[:_json][0][:phone]!=nil
        Bid.update_bid(params)
      end
      BidList.update_bidlist(params)
      Winner.update_winner(params)
    end
    redirect_to '/shows/show'
  end

end