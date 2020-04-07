# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :set_user

  def create
    follower = current_user.follow(@user)
    notice_message = follower.save ? "フォロー成功" : "フォロー失敗"
    redirect_back(fallback_location: users_path, notice: notice_message)
  end

  def destroy
    follower = current_user.unfollow(@user)
    notice_message = follower.destroy ? "フォロー解除成功" : "フォロー解除失敗"
    redirect_back(fallback_location: users_path, notice: notice_message)
  end

  private
    def set_user
      @user = User.find(params[:following][:follow_id])
    end
end
