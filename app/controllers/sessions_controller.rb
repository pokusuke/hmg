class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to root_url
    else
      redirect_to login_path
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
