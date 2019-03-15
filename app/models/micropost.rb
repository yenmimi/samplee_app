class Micropost < ApplicationRecord
  belongs_to :user

  scope :order_time, ->{order created_at: :desc}
  scope :following_microposts, ->(following, id_user){where "user_id IN (?) OR user_id = ?", following.to_s, id_user.to_s}

  mount_uploader :picture, PictureUploader

  validates :user, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost_validates.max_leght_content}
  validate :picture_size

  private

  def picture_size
    errors.add(:picture, t(".error_size_img")) if picture.size > Settings.micropost_validates.five.megabytes
  end
end
