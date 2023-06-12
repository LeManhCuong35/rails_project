class User < ApplicationRecord
  validates :name, :email, :password, presence: true

  has_many :articles, dependent: :destroy
end
