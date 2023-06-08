class Article < ApplicationRecord
  attribute :title, :string
  attribute :body, :text
  attribute :status, :integer
  attribute :user_id, :integer

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :status, presence: true
  validates_presence_of :user_id

  enum status: [:pending, :approved], _suffix: true

  scope :pending_articles, -> { where(status: :pending) }
  scope :approved_articles, -> { where(status: :approved) }

  belongs_to :user
end
