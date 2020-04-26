class Log < ApplicationRecord
  mount_uploader :map_file, MapImgUploader

  has_many :living_thing_imgs
  accepts_nested_attributes_for :living_thing_imgs

  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :weather
  belongs_to_active_hash :suits
end
