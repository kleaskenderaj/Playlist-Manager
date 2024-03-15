class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def current_user
      if session[:user_id] && User.exists?(session[:user_id])
        @current_user ||= User.find(session[:user_id])
      else
        @current_user = nil
      end
    end
      
    def logged_in?
      return true if current_user
      false
    end

    def require_user
      unless logged_in?
        flash[:alert] = "You must be logged in to perform that action!"
        redirect_to login_path
      else
        current_user
      end
    end


end
