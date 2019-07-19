class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    unless @user.nil?
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
