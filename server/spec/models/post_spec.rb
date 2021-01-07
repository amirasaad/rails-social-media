# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'with 2 or more comments' do
    it 'orders them in chronologically' do
      post = described_class.create!(body: 'new post')
      comment1 = post.comments.create!(body: 'first comment')
      comment2 = post.comments.create!(body: 'second comment')
      expect(post.reload.comments).to eq([comment1, comment2])
    end
  end
end
