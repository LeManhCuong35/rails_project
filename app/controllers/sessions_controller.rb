class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email).downcase
    if user&.authenticate params.dig(:session, :password)
      if user.activated?
        log_in user
        params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      else
        flash[:warning] = t "users.edit.check_your_email"
      end
      redirect_to root_url
    else
      flash[:warning] = t "users.new.failed"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
