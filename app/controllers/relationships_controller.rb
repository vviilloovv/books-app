# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    user = set_user
    following = current_user.follow(user)
    notice_message = following.save ? "フォロー成功" : "フォロー失敗"
    redirect_back(fallback_location: users_path, notice: notice_message)
  end

  def destroy
    user = set_user
    following = current_user.unfollow(user)
    notice_message = following.destroy ? "フォロー解除成功" : "フォロー解除失敗"
    redirect_back(fallback_location: users_path, notice: notice_message)
  end

  private
    def set_user
      User.find(params[:relationship][:follow_id])
    end
end
