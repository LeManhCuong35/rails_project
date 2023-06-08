class User < ApplicationRecord
  attribute :name, type: String
  attribute :email, type: String
  attribute :password, type: String

  validates_presence_of :name, :email, :password

  has_many :articles
end
