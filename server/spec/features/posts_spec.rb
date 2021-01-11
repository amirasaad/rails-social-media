# frozen_string_literal: true

require 'rails_helper'

describe 'User can create a post after login' do
  fixtures :users
  before do
    @user = users(:morty)
    passwordless_sign_in @user
  end

  it 'can create post' do
    visit '/'
    fill_in 'post[body]', with: 'New post'
    click_button 'Share'
    expect(page).to have_content(/New Post/i)
  end
end
