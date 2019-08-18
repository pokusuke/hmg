class EventsController < ApplicationController
  before_action :logged_in_user, only:[:new,:create,:destroy]
  def index
    if params[:pref_id].present?
      @pref = Pref.find(params[:pref_id])
      if params[:commit]
        event_date_from = Time.zone.local(params["event_date_from(1i)"].to_i,params["event_date_from(2i)"].to_i,params["event_date_from(3i)"].to_i)
        if params["event_date_to(li)"]
          event_date_to = Time.zone.local(params["event_date_to(1i)"].to_i,params["event_date_to(2i)"].to_i,params["event_date_to(3i)"].to_i)
        else
          logger.debug("=====日付復元できるか====")
          event_date_to = nil
        end
      else
        event_date_from = Time.zone.parse(params[:event_date_from])
        event_date_to = nil
      end
      @event_date_from = event_date_from
      @event_date_to = event_date_to
      
      #events検索
      @events = Event.search_with_pref(params[:pref_id])
      if @event_date_from
        @events = @events.search_with_start(event_date_from)
      end
      if @event_date_to
        @events = @events.search_with_end(event_date_to)
      end

    else 
      @event_date_from = Time.zone.now
      @events = Event.all
    end
  end

  def new
    @event =Event.new
  end

  def create
    begin
      ActiveRecord::Base.transaction{      
        #イベントを保存
        event = Event.new(event_params)
        event.user_id = current_user.id
        event.event_date = Time.zone.local(params[:event]["event_date(1i)"].to_i,params[:event]["event_date(2i)"].to_i,params[:event]["event_date(3i)"].to_i)
        event.event_recruit_start_date = Time.zone.local(params[:event]["event_recruit_start_date(1i)"].to_i,params[:event]["event_recruit_start_date(2i)"].to_i,params[:event]["event_recruit_start_date(3i)"].to_i)
        event.event_recruit_end_date = Time.zone.local(params[:event]["event_recruit_end_date(1i)"].to_i,params[:event]["event_recruit_end_date(2i)"].to_i,params[:event]["event_recruit_end_date(3i)"].to_i)
        event.save!

        #イベント参加者に作成者を追加
        event_app = EventApp.new
        event_app.event_id = event.id
        event_app.user_id = current_user.id
        event_app.save!
      }
    rescue Exception => e
      p e
      
    end
    redirect_to events_path
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    event = Event.find(params[:id])
    event.update_attributes!(event_name:params[:event][:event_name],user_id: current_user.id , event_date: Time.zone.local(params[:event]["event_date(1i)"].to_i,params[:event]["event_date(2i)"].to_i,params[:event]["event_date(3i)"].to_i))

  end

  def show
    @event = Event.find(params[:id])
  end

  def destory
  end

  private
    def event_params
      params.require(:event).permit(
        :event_name,
        :event_date,
        :pref_id,
        :city,
        :place_detail,
        :event_recruit_start_date,
        :event_recruit_end_date,
        :event_recruit_number,
        :event_entrance_fee,
        :event_detail,
        :photo_url1,
        :photo_url2,
        :photo_url3,
        :photo_url4 
      )
    end
end
