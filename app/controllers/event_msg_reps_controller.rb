class EventMsgRepsController < ApplicationController
  before_action :logged_in_user, only:[:index,:create,:new]

  def new
    @event_msg_reps = EventMsgRep.where(event_msg_id: params[:event_msg_id])
    @event_msg_rep = EventMsgRep.new
    @event_msg_id = params[:event_msg_id]
    @event_msg = EventMsg.find(@event_msg_id)
  end

  def create
    event_msg_rep = EventMsgRep.new
    event_msg_rep.msg = params[:event_msg_rep][:msg]
    event_msg_rep.event_msg_id = params[:event_msg_rep][:event_msg_id]
    event_msg_rep.rep_user_id = current_user.id
    event_msg_rep.save!
    redirect_to event_msgs_path(event_id: event_msg_rep.event_msg.event_id)
  end
end
