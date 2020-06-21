class LogsController < ApplicationController
  def index
    @logs = Log.all.order(id: "DESC")
  end

  def new
    @log = Log.new
    @log.living_thing_imgs.build
    gon.log_imgs = @log
  end

  def create
    @log = Log.new(log_params)
    if imgs_params[:arr_new_imgs]
      if @log.save
        imgs_params[:arr_new_imgs].each do |new_img|
          @log.living_thing_imgs.create(log_id: @log.id, l_img_file: new_img)
        end
      end
    end
  end

  def show
    @log = Log.find(params[:id])
    gon.log = @log
    gon.imgs = @log.living_thing_imgs

  end

  def edit
    @log = Log.find(params[:id])
    gon.imgs = @log.living_thing_imgs
    gon.log = @log

  end

  def update
    @log = Log.find(params[:id])

    if @log.update(log_params)
      ids = []
      remaining_ids = []

      # 現在の写真データについて
      if @log.living_thing_imgs.length != 0
        ids = @log.living_thing_imgs.map{|x| x.id}
      end

      #消すデータについて
      if imgs_params[:arr_remaining_ids]
        remaining_ids = imgs_params[:arr_remaining_ids].map{|x| x.to_i}
      end
      delete_ids = ids - remaining_ids
      if delete_ids.length != 0
        delete_ids.each do |id|
          @log.living_thing_imgs.find(id).destroy
        end
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
    params.require(:log).permit(:diving_map, :living_thing, :description, :d_date, :weather_id, :temp, :prefecture_id, :address, :w_temp, :visibility, :current, :d_no, :point, :entry_method, :entry_time, :exit_time,  :entry_air, :exit_air, :suits_id, :suits_thickness, :weight, :tank_type, :tank_volume).merge(user_id: current_user.id)
  end

  def imgs_params
    params.require(:log).permit({arr_remaining_ids: []}, {arr_new_imgs: []})
  end
end
