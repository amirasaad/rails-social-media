# frozen_string_literal: true

class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender, uniqueness: { scope: :receiver }

  has_many :personal_messages, -> { order(created_at: :asc) }, dependent: :destroy

  scope :participating, lambda { |user|
    where('(conversations.sender_id = ? OR conversations.receiver_id = ?)', user.id, user.id)
  }

  def with(current_user)
    sender == current_user ? receiver : sender
  end

  def participates?(user)
    sender == user || receiver == user
  end

  scope :between, lambda { |sender_id, receiver_id|
    where(sender_id: sender_id, receiver_id: receiver_id).or(where(sender_id: receiver_id, receiver_id: sender_id)).limit(1)
  }

  def self.get(sender_id, receiver_id)
    conversation = between(sender_id, receiver_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, receiver_id: receiver_id)
  end
end
