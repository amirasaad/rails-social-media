# frozen_string_literal: true

require 'digest'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  passwordless_with :email

  has_one :profile
  has_many :posts, -> { order('created_at DESC') }, dependent: :destroy
  has_many :replies, through: :posts, source: :comments

  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id',
                                   class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :sent_messages, class_name: 'Message',
                           foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message',
                               foreign_key: 'receiver_id'

  before_save { self.username = username.downcase }

  def self.find(query)
    find_by(username: query) || super(query)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end
end
