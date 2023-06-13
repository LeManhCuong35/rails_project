class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all
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
          redirect_to user_url @user,
                      notice: t("users.new.success")
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
          flash[:success] = t "user.edit.success"
          redirect_to user_url(@user),
                      notice: t("user.edit.success")
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
        redirect_to users_url,
                    notice: "User was successfully destroyed."
      end
      format.json{head :no_content}
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password
  end
end
