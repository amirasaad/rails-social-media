# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :reciver, class_name: 'User', optional: true

  validates :content, presence: true
end
