class LikesController < ApplicationController

  def create
    @log = Log.find(params[:log_id])
    if current_user != @log.user
      unless @log.goo?(current_user)
        @log.goo(current_user)
        @log.reload
        respond_to do |format|
          format.html {redirect_to request.referrer || root_url}
          format.js
        end
      end
    end
  end

  def destroy
    @log = Like.find(params[:id]).log
    if current_user != @log.user
      if @log.goo?(current_user)
        @log.boo(current_user)
        @log.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    end
  end
end