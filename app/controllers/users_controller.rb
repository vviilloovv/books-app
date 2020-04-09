# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :login_required

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id).order(created_at: "DESC").page(params[:page])
  end
end
