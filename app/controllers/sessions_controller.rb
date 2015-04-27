class SessionsController < ApplicationController

  def create
    if user = User.authenticate(session_params)
      log_in(user)
      redirect_to user
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
