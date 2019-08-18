class HomeController < ApplicationController
  def index
    @areas = Area.all
    @events = Event.limit(10).order('created_at')
  end
end
