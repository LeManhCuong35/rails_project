module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id) if session[:user_id]
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user&.authenticated? cookies.signed[:remember_token]
        log_in user
        @current_user = user
      end
    end
  end

  def current_user? user
    user && user == current_user
  end

  def remember user
    user.remember
    cookies.signed[:user_id] =
      {value: user.id, expires: Settings.user.expired_2.days.from_now.utc}
    cookies[:remember_token] =
      {
        value: user.remember_token,
        expires: Settings.user.expired_2.days.from_now.utc
      }
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def forget _user
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def logged_in_user
    redirect_to login_path if current_user.blank?
  end

  def admin_role? user
    current_user.admin? && current_user.id != user.id
  end
end
