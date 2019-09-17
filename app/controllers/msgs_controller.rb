class MsgsController < ApplicationController
  before_action :authenticate_user!, only:[:index,:select_user,:new,:create,:destroy]
  def index
    @msg_users = MsgUser.where("user_id=#{current_user.id}")
  end
  
  def select_user
    if request.referer&.include?("/msgs/select_user")
    else
      session[:query_users]=nil
    end
  end

  def query_user
    session[:query_users] = nil
    query_users = query
    session[:query_users] = query_users
    redirect_to "/msgs/select_user"
    #render action: "select_user"
  end

  def new
    @msg = Msg.new 
    cid = current_user.id
    @recv_user = User.find_by(id:params[:id].split("&")[0])
    @msgs = Msg.where("(sender_id = #{params[:id].split("&")[0]} and reciever_id= #{cid}) or (sender_id = #{cid} and reciever_id = #{params[:id].split("&")[0]})")
  end

  def create
    msg = Msg.new
    msg.sender_id = current_user.id
    msg.reciever_id = params[:id]
    msg.msg = params[:msg][:msg]
    msg.save!
    redirect_to "/msgs/#{params[:id]}"
  end

  private
    def query
      if params[:user].present? && !params[:user][:name].empty?
         users = User.where('nick_name LIKE ? AND id !=?',"%#{params[:user][:name]}%",current_user.id)
         users
      else
         []
      end
    end
end
