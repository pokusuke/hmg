class StoresController < ApplicationController
  before_action :logged_in_user, only:[:index,:create,:new]
  
  def index
    @store = Store.find_by(id:params[:event_app_id])
  end

  def create
    event_app = EventApp.find_by(id: params[:store][:event_app_id])
    store = Store.new
    store.event_app_id = event_app.id
    store.event_id = event_app.event_id
    store.store_owner_id = current_user.id
    store.store_desc = params[:store][:store_desc]
    store.save!
    redirect_to stores_path(event_app_id: event_app.id)
  end

  def new
    @event_app_id = params[:event_app_id]
    @store =Store.new
  end

  def update
  end

end
