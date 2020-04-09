# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :login_required
  before_action :set_comment, only: [:update, :destroy]
  before_action :check_user, only: [:update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = current_user.comments.order(created_at: "DESC").page(params[:page])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: comments_url, notice: "Comment was successfully created.") }
        format.json { render :index, status: :created, location: @comment }
      else
        format.html { render :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_back(fallback_location: comments_url, notice: "Comment was successfully updated.") }
        format.json { render :index, status: :ok, location: @comment }
      else
        format.html { render :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: comments_url, notice: "Comment was successfully destroyed.") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end

    def check_user
      redirect_to comments_url, notice: "Illegal request." unless current_user.id == @comment.user_id
    end
end
