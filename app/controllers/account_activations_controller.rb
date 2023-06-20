class AccountActivationsController < ApplicationController
  before_action :load_user, only: :edit

  def edit
    if @user.authenticated?(:activation, params[:id]) && !@user.activated?
      @user.activate
      log_in @user
      flash[:success] = t "users.edit.account_activated"
      redirect_to @user
    else
      flash[:danger] = t "users.edit.invalid_activation_link"
      redirect_to root_path
    end
  end

  private
  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "users.new.failed"
    redirect_to root_path
  end
end
