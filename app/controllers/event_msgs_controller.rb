class EventMsgsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create new]
  before_action :event_app_auth, only: [:index]

  def index
    @event_msgs = EventMsg.where(event_id: params[:event_id])
    @event_id = params[:event_id]
    @event = Event.find_by(id: params[:event_id])
    @event_msg = EventMsg.new
  end

  def create
    event_msg = EventMsg.new
    event_msg.event_id = params[:event_msg][:event_id]
    event_msg.sender_id = current_user.id
    event_msg.msg = params[:event_msg][:msg]
    event_msg.photo_url = params[:event_msg][:photo_url]
    event_msg.save! if event_msg.msg.present? || event_msg.photo_url.present?
    redirect_to event_msgs_path(event_id: event_msg.event_id)
  end

  private

  def event_app_auth
    @event_app = EventApp.find_by(event_id: params[:event_id], user_id: current_user.id)
    redirect_to event_apps_path if @event_app.nil?
  end
end
