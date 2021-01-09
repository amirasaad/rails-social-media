require 'rails_helper'

feature 'User can comment on posts' do
  fixtures :users, :posts
  before :each do
    @user = users(:morty)
    @post = posts(:rick_post)
    passwordless_sign_in @user
  end
  scenario 'can comment on post' do
    visit posts_path
    fill_in 'comment[body]', with: 'Nice'
    click_button 'Comment'
    expect(page).to have_content("your comment is posted")
  end
end
