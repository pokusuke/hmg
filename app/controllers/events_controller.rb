class EventsController < ApplicationController
  before_action :logged_in_user, only:[:new,:create,:destroy]
  def index
    if params[:pref_id]
      @pref = Pref.find(params[:pref_id])
      @events = Event.all
    else 
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
        event.save!

        #イベント参加者に作成者を追加
        event_app = EventApp.new
        event_app.event_id = event.id
        event_app.user_id = current_user.id
        event_app.save!
      }
    rescue Exception => e
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
      params.require(:event).permit(:event_name,:event_date)
    end
end
