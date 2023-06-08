class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  enum status: {pending: 0, approve: 1}, _suffix: true

  scope :pending_articles, ->{where(status: :pending)}
  scope :approved_articles, ->{where(status: :approved)}

  belongs_to :user
end
