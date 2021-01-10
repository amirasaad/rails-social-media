# frozen_string_literal: true

class Post < ApplicationRecord
  validates :body, presence: true

  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy

  scope :where_body, ->(term) { where('posts.body LIKE ?', "%#{term}%") }

  def owned_by?(owner)
    return false unless owner.is_a?(User)

    user == owner
  end

  def latest_comments
    comments.order('created_at DESC').take(2)
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
