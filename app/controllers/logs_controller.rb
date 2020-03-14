class LogsController < ApplicationController
  def new
    @log = Log.new
    @log.living_thing_imgs.build
  end
  
  def create
    @log = Log.new(log_params)
    @log.d_date = Date.new(params[:log]["d_date(1i)"].to_i, params[:log]["d_date(2i)"].to_i, params[:log]["d_date(3i)"].to_i).strftime("%Y-%m-%d")
    @log.entry_time = Time.new(params[:log]["entry_time(1i)"].to_i, params[:log]["entry_time(2i)"].to_i, params[:log]["entry_time(3i)"].to_i, params[:log]["entry_time(4i)"].to_i, params[:log]["entry_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    @log.exit_time =  Time.new(params[:log]["exit_time(1i)"].to_i,  params[:log]["exit_time(2i)"].to_i,  params[:log]["exit_time(3i)"].to_i,  params[:log]["exit_time(4i)"].to_i,  params[:log]["exit_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    @log.save
  end

  def show
    @log = Log.find(params[:id])
  end


  private
  def log_params
    params.require(:log).permit(:map_file, :living_thing, :description, :d_date, :weather_id, :temp, :prefecture_id, :address, :w_temp, :visibility, :current, :d_no, :point, :entry_method, :entry_time, :exit_time,  :entry_air, :exit_air, :suits_type_id, :suits_thickness, :weight, :tank_type, :tank_volume, living_thing_imgs_attributes: [:l_img_file])
  end

end
