class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by_credentials(session_params[:username], session_params[:password])
    if user.save
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["invalid user credentials"]
      render :new
    end
  end

  def destroy
    log_out_user!
    redirect_to new_session_url
  end


  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
