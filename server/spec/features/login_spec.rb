require 'rails_helper'

describe "Login" do
  fixtures :users

  let(:user) { users(:morty) }

    it "sends a user an email" do
        visit "/users/sign_in"
        fill_in "passwordless[email]", with: user.email
        expect {
            click_button "Edeny 2lbak"
        }.to change{ ActionMailer::Base.deliveries.size}.by(1)
    end

    it "logs in user when following the email link" do
        visit "/users/sign_in"
        fill_in "passwordless[email]", with: user.email
        click_button "Edeny 2lbak"
        open_email(user.email)
        current_email.click_link "https://"
        expect(page).to have_content("5od 2lby")

    end

end