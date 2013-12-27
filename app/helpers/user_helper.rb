module UserHelper

  def update_session(user)
    session[:answer]=user.answer
    session[:account]= user.name
    session[:question] = user.question
  end
end
