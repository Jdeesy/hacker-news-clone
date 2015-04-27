class SessionsController < ApplicationController

  def create
    if user = User.authenticate(session_params)
      session[:user_id] = user.id
      redirect_to user
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
