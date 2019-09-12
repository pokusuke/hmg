module SessionsHelper
#  def log_in(user)
#    session[:user_id] = user.id 
#  end
  
#  def current_user
#    if(user_id = session[:user_id])
#      @current_user ||= User.find_by(id: user_id)
#    end
#  end

#  def forget(user)
#    #user.forget
#    cookies.delete(:user_id)
#  end

 # def log_out
  #  forget(current_user)
 #   session.delete(:user_id)
 #   @current_user = nil
  #end

  #def logged_in?
  #  !current_user.nil?
  #end

  def is_apply_event?
    cid = current_user
    unless cid.nil?
      !!EventApp.find_by(user_id: cid, event_id: params[:id])
    else
      false
    end  
  end
end
