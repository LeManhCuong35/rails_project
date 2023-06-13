class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: {with: Regexp.new(Settings.user.regex_email)}
  validates :password, presence: true,
    length: {minimum: Settings.user.min_6}, if: :password

  has_many :articles, dependent: :destroy

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
