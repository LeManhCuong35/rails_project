class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true,
length: {maximum: Settings.articles.max_body_140}
  validates :status, presence: true
  validates :user_id, presence: true
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png)},
                    size: {less_than: Settings.articles.image_max_5.megabytes}

  enum status: {pending: 0, approve: 1}, _suffix: true

  scope :pending_articles, ->{where(status: :pending)}
  scope :approved_articles, ->{where(status: :approved)}
  scope :newest, ->{order created_at: :desc}
  scope :load_by_id, ->(user_id){where "user_id = ?", "#{user_id}.to_s"}

  belongs_to :user
  has_one_attached :image

  def display_image
    image.variant resize_to_limit: [
                                    Settings.articles.image_200,
                                    Settings.articles.image_200
                                  ]
  end
end
