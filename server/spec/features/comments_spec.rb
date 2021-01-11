# frozen_string_literal: true

require 'rails_helper'

describe 'User can comment on posts' do
  fixtures :users, :posts
  before do
    @user = users(:morty)
    @post = posts(:rick_post)
    passwordless_sign_in @user
  end

  it 'can comment on post' do
    visit posts_path
    fill_in 'comment[body]', with: 'Nice'
    click_button 'Comment'
    expect(page).to have_content('your comment is posted')
  end
end
