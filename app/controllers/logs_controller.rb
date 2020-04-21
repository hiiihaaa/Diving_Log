class LogsController < ApplicationController
  def index
    @logs = Log.all
  end

  def new
    @log = Log.new
    @log.living_thing_imgs.build
  end

  include CarrierwaveBase64Uploader
  def create
    @log = Log.new(log_params)
    @log.map_file = base64_conversion(map_params[:base64_map])
    @log.d_date = Date.new(params[:log]["d_date(1i)"].to_i, params[:log]["d_date(2i)"].to_i, params[:log]["d_date(3i)"].to_i).strftime("%Y-%m-%d")
    @log.entry_time = Time.new(params[:log]["entry_time(1i)"].to_i, params[:log]["entry_time(2i)"].to_i, params[:log]["entry_time(3i)"].to_i, params[:log]["entry_time(4i)"].to_i, params[:log]["entry_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    @log.exit_time =  Time.new(params[:log]["exit_time(1i)"].to_i,  params[:log]["exit_time(2i)"].to_i,  params[:log]["exit_time(3i)"].to_i,  params[:log]["exit_time(4i)"].to_i,  params[:log]["exit_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    @log.save
    if @log.save
      params[:imgs].each do |img|
        @log.living_thing_imgs.create(log_id: @log.id, l_img_file: img)
      end
      redirect_to log_path(@log.id)
    else
      render action: 'index'
    end
    
  end

  def show
    @log = Log.find(params[:id])
  end


  private
  def log_params
    params.require(:log).permit(:map_file, :living_thing, :description, :d_date, :weather_id, :temp, :prefecture_id, :address, :w_temp, :visibility, :current, :d_no, :point, :entry_method, :entry_time, :exit_time,  :entry_air, :exit_air, :suits_id, :suits_thickness, :weight, :tank_type, :tank_volume, living_thing_imgs_attributes: [:l_img_file])
  end
  def map_params
    params.require(:log).permit(:base64_map)
  end
end
