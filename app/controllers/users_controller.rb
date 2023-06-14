class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update index)
  before_action :set_user, only: %i(show edit update destroy)
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: %i(edit update)

  def index
    @pagy, @users = pagy User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params

    respond_to do |format|
      if @user.save
        flash[:success] = t "users.new.success"
        format.html do
          redirect_to user_url @user
        end
        format.json{render :show, status: :created, location: @user}
      else
        format.html{render :new, status: :unprocessable_entity}
        format.json{render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update user_params
        format.html do
          flash[:success] = t "users.edit.success"
          redirect_to user_url @user
        end
        format.json{render :show, status: :ok, location: @user}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json{render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_url
        flash[:success] = t "users.edit.success"
      end
      format.json{head :no_content}
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = t "users.new.must_be_admin"
      redirect_to root_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user? @user
  end
end
