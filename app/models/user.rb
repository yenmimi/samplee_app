class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :remember_token
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
            foreign_key: "follower_id",
            dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
            foreign_key: "followed_id",
            dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true,
            length: {maximum: Settings.user_validates.max_leght_name}
  validates :email, presence: true,
            length: {maximum: Settings.user_validates.max_leght_email},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.user_validates.min_leght_pass},
            allow_nil: true

  scope :following_microposts, ->{where("user_id IN (?) OR user_id = ?", following_ids, id)}
  scope :oder_user, ->{order name: :asc}

  has_secure_password

  before_save :email_downcase

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                        BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def current_user? user
    self == user
  end

  def forget
    update remember_digest: nil
  end

  def feed
    Micropost.following_microposts following_ids, id
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def email_downcase
    email.downcase!
  end
end
