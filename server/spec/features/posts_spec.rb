require 'rails_helper'

feature 'User can create a post after login' do
  fixtures :users
  before :each do
    @user = users(:morty)
    passwordless_sign_in @user
  end
  scenario 'can create post' do
    visit '/'
    fill_in 'post[body]', with: 'New post'
    click_button 'Share'
    expect(page).to have_content(/New Post/i)
  end
end
