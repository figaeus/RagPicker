class SessionsController < ApplicationController

  def create
    user = User.authenticate params[:assertion]
    if user.nil?
      head :not_acceptable
    else
      session[:email] = user.attributes[:email]
      head :ok
    end
  end

  def destroy
    session[:email] = nil
    head :ok
  end

end
