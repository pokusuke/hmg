class EventMsgsController < ApplicationController
  before_action :logged_in_user, only:[:index,:create,:new]

  def index
    @event_msgs = EventMsg.where(event_id: params[:event_id])
    @event_id = params[:event_id]
    @event_msg = EventMsg.new
  end

  def create
   event_msg = EventMsg.new
   event_msg.event_id = params[:event_msg][:event_id]
   event_msg.sender_id = current_user.id
   event_msg.msg = params[:event_msg][:msg]
   event_msg.save!
   redirect_to event_msgs_path(event_id: event_msg.event_id)
  end
end
