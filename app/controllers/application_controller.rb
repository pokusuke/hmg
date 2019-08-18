class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  private
    def logged_in_user
      unless logged_in?
        redirect_to login_path
      end
    end
end
