class Log < ApplicationRecord

  has_many :living_thing_imgs
  mount_uploader :diving_map, DivingMapUploader
  accepts_nested_attributes_for :living_thing_imgs

  has_many   :likes, dependent: :destroy
  has_many   :goo_users, through: :likes, source: :user
  has_many   :comments, dependent: :destroy
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :weather
  belongs_to_active_hash :suits

  def main_preview(log)
    if log.diving_map
      log.diving_map.url
    elsif log.living_thing_imgs
      log.living_thing_imgs[0].url
    else
      'image-regular.svg'
    end
  end

  def goo(user)
    likes.create(user_id: user.id)
  end

  def boo(user)
    likes.find_by(user_id: user.id).destroy
  end

  def goo?(user)
    goo_users.include?(user)
  end

  def pos_come(user, comment)
    comments.create(user_id: user.id, comment_text: comment)
  end
end
