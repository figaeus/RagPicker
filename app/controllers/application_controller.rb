class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_login

  private

  def check_login
    if session[:email]
      @current_user_email = session[:email]
    end
  end

end
