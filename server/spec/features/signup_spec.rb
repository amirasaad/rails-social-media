# frozen_string_literal: true

require 'rails_helper'

describe 'Signup without passwords' do
  let(:user) { User.create! email: 'test@test.com', username: 'test' }

  it 'User can sign up with only username and email' do
    visit '/register'

    fill_in 'Username', with: 'rick'
    fill_in 'Email', with: 'rick@univrse.test'
    click_button 'Register'

    expect(page).to have_text('Nwartt! <3')
  end
end
