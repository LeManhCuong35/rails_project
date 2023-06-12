class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: {with: ->{Settings.user.regex_email}}
  validates :password, presence: true,
    length: {minimum: ->{Settings.user.min}}, if: :password

  has_many :articles, dependent: :destroy

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
