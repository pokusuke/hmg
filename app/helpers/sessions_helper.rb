module SessionsHelper

  def is_apply_event?
    cid = current_user
    if cid.nil?
      false
    else
      !!EventApp.find_by(user_id: cid, event_id: params[:id])
    end
  end
  
  def admin_user                                                           
    redirect_to(root_url) unless current_user.admin?
  end
end
