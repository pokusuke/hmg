class EventAppsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create destroy]
  def index
    @event_apps = EventApp.where(user_id: current_user.id)
  end

  def create
    event_app = EventApp.new
    event_app.event_id = params[:event][:event_id]
    event_app.user_id = current_user.id
    event_app.save!
    flash[:success] = 'イベントに応募しました'
    redirect_to event_app_path(event_app)
  end

  def show
    @event_app = EventApp.find(params[:id])
    redirect_to event_apps_path if @event_app.user_id != current_user.id
  end

  def destroy
    event_app = EventApp.find(params[:id])
    event_app.destroy
    flash[:success] = '応募を取消ました'
    redirect_to event_apps_path
  end
end
