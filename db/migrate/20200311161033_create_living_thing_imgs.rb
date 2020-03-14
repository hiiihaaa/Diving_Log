class CreateLivingThingImgs < ActiveRecord::Migration[5.2]
  def change
    create_table :living_thing_imgs do |t|
      t.integer :log_id, foreign_key: true
      t.string  :l_img_file
    end
  end
end
