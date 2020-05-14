class LogsController < ApplicationController
  before_action :user_dummy
  def index
    @logs = Log.all
  end

  def new
    @log = Log.new
    @log.living_thing_imgs.build
  end

  def create
    @log = Log.new(log_params)

    @log.d_date = Date.new(params[:log]["d_date(1i)"].to_i, params[:log]["d_date(2i)"].to_i, params[:log]["d_date(3i)"].to_i).strftime("%Y-%m-%d")
    @log.entry_time = Time.new(params[:log]["entry_time(1i)"].to_i, params[:log]["entry_time(2i)"].to_i, params[:log]["entry_time(3i)"].to_i, params[:log]["entry_time(4i)"].to_i, params[:log]["entry_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    @log.exit_time =  Time.new(params[:log]["exit_time(1i)"].to_i,  params[:log]["exit_time(2i)"].to_i,  params[:log]["exit_time(3i)"].to_i,  params[:log]["exit_time(4i)"].to_i,  params[:log]["exit_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    if @log.save && imgs_params[:arr_new_imgs]
      imgs_params[:arr_new_imgs].each do |new_img|
        @log.living_thing_imgs.create(log_id: @log.id, l_img_file: new_img)
      end
    end
  end

  def show
    @log = Log.find(params[:id])
  end

  def edit
    @log = Log.find(params[:id])
    gon.current_imgs = @log.living_thing_imgs
    gon.log_imgs = @log
  end

  def update
    @log = Log.find(params[:id])
    @log.d_date = Date.new(params[:log]["d_date(1i)"].to_i, params[:log]["d_date(2i)"].to_i, params[:log]["d_date(3i)"].to_i).strftime("%Y-%m-%d")
    @log.entry_time = Time.new(params[:log]["entry_time(1i)"].to_i, params[:log]["entry_time(2i)"].to_i, params[:log]["entry_time(3i)"].to_i, params[:log]["entry_time(4i)"].to_i, params[:log]["entry_time(5i)"].to_i).strftime("%Y-%m-%d-%H:%M")
    ids = []
    current_map_id = []
    

    if @log.update(log_params)
      # 現在の写真データについて
      @log.living_thing_imgs.each do |img|
        if img[:l_img_file].include?("diving-map")
          current_map_id << img[:id]
        else
          ids << img[:id]
        end
      end
      
      #消すデータについて
      if @log.living_thing_imgs
        if imgs_params[:arr_remaining_ids]
          remaining_ids = imgs_params[:arr_remaining_ids].map{|x| x.to_i}
          delete_ids = ids - remaining_ids
        else
          delete_ids = ids

          if imgs_params[:arr_remaining_ids] && imgs_params[:arr_remaining_ids].length < ids.length
            delete_ids = ids - imgs_params[:arr_remaining_ids]
            delete_ids.each do |id|
              @log.living_thing_imgs.find(id).destroy
            end
          end
        end
      end

      # 新しいmap
      if imgs_params[:new_map]
        if current_map_id[0]
          @log.living_thing_imgs.find(current_map_id[0]).destroy
        end
        @log.living_thing_imgs.create(log_id: @log.id, l_img_file: imgs_params[:new_map])
      end
      # 新しい写真
      if imgs_params[:arr_new_imgs]
        imgs_params[:arr_new_imgs].each do |new_img|
          @log.living_thing_imgs.create(log_id: @log.id, l_img_file: new_img)
        end
      end
    end
  end


  private
  def log_params
    params.require(:log).permit(:living_thing, :description, :d_date, :weather_id, :temp, :prefecture_id, :address, :w_temp, :visibility, :current, :d_no, :point, :entry_method, :entry_time, :exit_time,  :entry_air, :exit_air, :suits_id, :suits_thickness, :weight, :tank_type, :tank_volume).merge(user_id: current_user.id)
  end



  def imgs_params
    params.require(:log).permit({arr_remaining_ids: []}, {arr_new_imgs: []}, :new_map)
  end
  
  def user_dummy
    @user = User.new
  end
end
