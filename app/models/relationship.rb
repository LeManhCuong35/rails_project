class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  scope :load_by_id, -> (id){ where id: id }
  scope :load_followings, -> (id){ where follower_id: id }
end
