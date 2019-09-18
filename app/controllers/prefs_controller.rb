class PrefsController < ApplicationController
  def index
    @prefs = Pref.all
  end

  def new
    @pref = Pref.new
  end

  def create
    pref = Pref.new
    pref.area_id = params[:pref][:area_id]
    pref.pref_id = params[:pref][:pref_id]
    pref.pref_name = params[:pref][:pref_name]
    pref.save!
    redirect_to prefs_path
  end

  def edit
    @pref = Pref.find(params[:id])
  end

  def update
    pref = Pref.find(params[:id])
    if pref.update_attributes(area_id: params[:pref][:area_id], pref_id: params[:pref][:pref_id], pref_name: params[:pref][:pref_name])
      redirect_to prefs_path
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    pref = Pref.find(params[:id])
    pref.destroy
  end
end
