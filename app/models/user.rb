class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :logs
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :nickname, presence: true

  def user_photo(user)
    if user.photo
      user.photo.to_s
    else
      "user-circle-solid.svg"
    end
  end
end
