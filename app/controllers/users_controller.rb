class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save!
    redirect_to users_path
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render 'edit'
    else
      render 'edit'
    end
  end
  
  def destroy
    log_out
    redirect_to login_path
  end

  def user_params
    params.require(:user).permit(:name,:nick_name,:avatar_path)
  end
end
