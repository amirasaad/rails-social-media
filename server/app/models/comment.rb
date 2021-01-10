class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user, optional: true

  validates_presence_of :body
end
