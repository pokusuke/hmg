class EventMsgRepsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create new]

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
    event_msg_rep.photo_url = params[:event_msg_rep][:photo_url]
    event_msg_rep.rep_user_id = current_user.id
    event_msg_rep.save!
    redirect_to event_msg_reps_new_path(event_msg_id: event_msg_rep.event_msg_id)
  end
end
