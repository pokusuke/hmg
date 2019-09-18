class AreasController < ApplicationController
  def index
    @areas = Area.all
  end

  def new
    @area = Area.new
  end

  def create
    area = Area.new
    area.area_name = params[:area][:area_name]
    area.save!
    redirect_to areas_path
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    area = Area.find(params[:id])
    if area.update_attributes(area_name: params[:area][:area_name])
      redirect_to areas_path
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    area = Area.find(params[:id])
    area.destroy
  end
end
