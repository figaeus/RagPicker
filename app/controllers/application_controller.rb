class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  private

  def current_user
    if session[:email].nil?
      @current_user = nil
    elsif @current_user.nil? or @current_user.email != session[:email]
      @current_user = User.find_by_email session[:email]
    end

    @current_user
  end

  def logged_in?
    not session[:email].nil?
  end

  def redir_unless_logged_in
    redirect_to controller: 'home', action: 'index' unless logged_in?
  end

  def fail_unless_logged_in
    head :user_not_authorized unless logged_in? 
  end
end
