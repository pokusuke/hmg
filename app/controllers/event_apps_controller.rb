class EventAppsController < ApplicationController
  before_action :authenticate_user!, only:[:index,:create]
  def index
    @event_apps = EventApp.where(user_id: current_user.id)
  end

  def create
    event_app = EventApp.new
    event_app.event_id = params[:event][:event_id]
    event_app.user_id = current_user.id
    event_app.save!
  end

  def show
    @event_app = EventApp.find(params[:id])
  end
end
