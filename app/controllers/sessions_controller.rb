class SessionsController < ApplicationController
  before_action :check_session_password, only: :create
  def new; end

  def create
    if @user.activated?
      log_in @user
      if params.dig(:session,
                    :remember_me) == "1"
        remember @user
      else
        forget @user
      end
    else
      flash[:warning] = t "users.edit.check_your_email"
    end

    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def check_session_password
    @user = User.find_by email: params.dig(:session, :email).downcase
    return if @user&.authenticate params.dig(:session, :password)

    flash.now[:warning] = t "users.new.failed"
    render :new
  end
end
