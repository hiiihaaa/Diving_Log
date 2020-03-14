class LivingThingImg < ApplicationRecord
  belongs_to :log, optional: true
  mount_uploader :l_img_file, LivingThingImgUploader
end
