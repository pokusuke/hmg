class HomeController < ApplicationController
  def index
    @areas = Area.all
  end
end
