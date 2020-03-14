class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string  :map_file
      t.string  :living_thing
      t.string  :description

      t.date    :d_date
      t.string  :weather_id
      t.float   :temp
      t.integer :prefecture_id
      t.string  :address

      t.float   :w_temp
      t.integer :visibility
      t.string  :current

      t.integer :d_no
      t.string  :point
      t.string  :entry_method
      t.time    :entry_time
      t.time    :exit_time
      t.integer :entry_air
      t.integer :exit_air

      t.integer :suits_type_id
      t.integer :suits_thickness
      t.float   :weight
      t.string  :tank_type
      t.integer :tank_volume    
    end
  end
end
