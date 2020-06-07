class CommentsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    @comment = Comment.create(user_id: current_user.id, log_id: params[:log_id], comment_text: params[:come_text])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.json
    end
  end

  def destroy
    @log = Comment.find(params[:id]).log
    Comment.find(params[:id]).destroy
    @log.reload
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js 
    end
  end
end