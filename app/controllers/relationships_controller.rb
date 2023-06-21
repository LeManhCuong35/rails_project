class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.load_by_id(params[:followed_id]).first
    current_user.follow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.load_by_id(params[:id]).first.followed
    current_user.unfollow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
