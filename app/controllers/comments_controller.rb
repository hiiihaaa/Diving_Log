class CommentsController < ApplicationController

  def create
    @log = Log.find(params[:log_id])
    @log.pos_come(current_user, params[:comment][:comment_text])
  end
end