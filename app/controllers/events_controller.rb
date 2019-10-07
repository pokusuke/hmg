class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  PER = 9
  def index
    if params[:commit]
      @event_date_from = Time.zone.local(params['event_date_from(1i)'].to_i, params['event_date_from(2i)'].to_i, params['event_date_from(3i)'].to_i)
      @event_date_to = Time.zone.local(params['event_date_to(1i)'].to_i, params['event_date_to(2i)'].to_i, params['event_date_to(3i)'].to_i) if params['event_date_to(1i)'].present?
    else
      @event_date_from = Date.current.in_time_zone
      @event_date_to = nil
    end

    # events検索
    @events = Event.where(event_published_flg: true)
    # @pref = Pref.find(params:[:pref_id])
    @events = @events.search_with_start(@event_date_from) if @event_date_from
    @events = @events.search_with_end(@event_date_to) if @event_date_to
    if params[:pref_id].present?
      @pref = Pref.find(params[:pref_id])
      @events = @events.search_with_pref(params[:pref_id])
    end
    @events = @events.order(event_date: :asc).page(params[:page]).per(PER)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(formatted_event_params)
    if @event.valid?
      begin
        ActiveRecord::Base.transaction do
          @event.save!
          # イベント参加者に作成者を追加
          event_app = EventApp.new
          event_app.event_id = @event.id
          event_app.user_id = current_user.id
          event_app.save!
        end
      rescue Exception => e
        p e
      end
      flash[:success] = 'イベントを登録しました'
      redirect_to events_path
    else
      flash.now[:error] = '不正な入力があります'
      render 'events/new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    @event_app = EventApp.find_by(event_id: @event.id, user_id: current_user.id)
  end

  def update
    @event = Event.find(params[:id])
    @event_app = EventApp.find_by(event_id: @event.id, user_id: current_user.id)
    if @event.update(formatted_event_params)
      flash.now[:success] = '保存しました'
    else
      flash.now[:error] = '不正な入力があります'
    end
    render 'events/edit'
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    flash[:success] = 'イベントを削除しました'
    redirect_to event_apps_path
  end

  private

  def event_params
    params.require(:event).permit(
      :event_name,
      :event_date,
      :pref_id,
      :city,
      :event_published_flg,
      :event_recruiting_flg,
      :place_detail,
      :event_date,
      :event_recruit_start_date,
      :event_recruit_end_date,
      :event_recruit_number,
      :event_entrance_fee,
      :event_detail,
      :photo_url1,
      :photo_url2,
      :photo_url3,
      :photo_url4,
      :remove_img1,
      :remove_img2,
      :remove_img3,
      :remove_img4
    )
  end

  def formatted_event_params
    attrs = event_params.to_h
    attrs[:user_id] = current_user.id
    attrs[:event_date] = Time.zone.local(params[:event]['event_date(1i)'].to_i, params[:event]['event_date(2i)'].to_i, params[:event]['event_date(3i)'].to_i)
    attrs[:event_recruit_start_date] = Time.zone.local(params[:event]['event_recruit_start_date(1i)'].to_i, params[:event]['event_recruit_start_date(2i)'].to_i, params[:event]['event_recruit_start_date(3i)'].to_i)
    attrs[:event_recruit_end_date] = Time.zone.local(params[:event]['event_recruit_end_date(1i)'].to_i, params[:event]['event_recruit_end_date(2i)'].to_i, params[:event]['event_recruit_end_date(3i)'].to_i)
    attrs
  end
end
