class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper
  protect_from_forgery

  private

  def logged_in_user
    unless logged_in?
      redirect_to login_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
  end
end
