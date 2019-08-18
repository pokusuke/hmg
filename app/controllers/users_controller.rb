class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = '保存しました'
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  
  end
  
  def destroy
    log_out
    redirect_to login_path
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:nick_name,:prof,:avatar_path)
  end
end
