class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true,
            length: {maximum: Settings.user_validates.max_leght_name}
  validates :email, presence: true,
            length: {maximum: Settings.user_validates.max_leght_email},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.user_validates.min_leght_pass}
  has_secure_password
  before_save :email_downcase

  private

  def email_downcase
    email.downcase! 
  end
end
