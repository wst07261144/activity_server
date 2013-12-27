module UserHelper

  def update_session(user)
    session[:answer]=user.answer
    session[:account]= user.name
    session[:question] = user.question
    session[:password] = user.password_digest
  end

  def get_params(params)
    return {:name => session[:account],:password=>params[:user][:password],
            :password_confirmation=> params[:user][:password_confirmation],
            :question=>session[:question], :answer=>session[:answer],
            :admin=>'false'}
  end

  def delete_user
    user = User.find_by_name session[:account]
    if user!=nil
      user.destroy
    end
  end

end
