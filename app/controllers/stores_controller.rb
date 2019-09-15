class StoresController < ApplicationController
  before_action :authenticate_user!, only:[:index,:create,:new]
  before_action :store_creator, only:[:index,:create,:new,:edit]
  
  def index
    @store = Store.find_by(event_app_id:params[:event_app_id])
  end

  def edit
    @store = Store.find_by(event_app_id:params[:event_app_id])
    render 'stores/index'
  end

  def new
    @event_app_id = params[:event_app_id]
    @store =Store.new
    render 'stores/new'
  end

  def create
    event_app = EventApp.find_by(id: params[:store][:event_app_id])
    @store = Store.new
    @store.event_app_id = event_app.id
    @store.event_id = event_app.event_id
    @store.store_owner_id = current_user.id
    @store.name = params[:store][:name]
    @store.store_desc = params[:store][:store_desc]
    @event_app_id=event_app.event_id
    
    if @store.save
      flash[:success] = '保存しました'
      redirect_to edit_event_app_store_path(@store.event_app_id,@store.id)
    else
      flash[:error] = '不正な入力があります'
      render 'stores/new'
    end
    
  end

  def update
    @store = Store.find_by(id:params[:store][:store_id])
    if @store.update(store_params)
      flash.now[:success] = "保存しました"
    else
      flash.now[:error] = "不正な入力があります"
    end
    render 'stores/index'
  end

  def show
    @store = Store.find_by(id:params[:id])
  end
  
  def destroy
    @store = Store.find_by(id:params[:id])
    event_app_id = @store.event_app_id

    @store.destroy
    flash[:success]='イベントを削除しました'
    redirect_to event_app_path(event_app_id)
  end
  private 

  def store_params
    params.require(:store).permit(
      :name,
      :store_desc,
    )
  end

  def store_creator
    event_app = EventApp.find_by(id: params[:event_app_id])
    unless event_app&.user_id == current_user.id
      redirect_to event_apps_path
    end
  end
end
