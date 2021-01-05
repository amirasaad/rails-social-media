require 'rails_helper'

feature "User can login by email" do
    let(:user) {User.create! :email => 'test@test.com', :username => 'test'}

    scenario "User should receive email for login" do
        visit "/users/sign_in"
        fill_in "passwordless[email]", :with => user.email
        click_button "Edeny 2lbak"
        open_email(user.email)
        expect(current_email.to).to eq [user.email]
        expect(current_email.subject).to eq '5od 2lby'
        expect(current_email).to have_content '5od 2lby <3'
        expect(current_email).to have_content '/users/sign_in/'
        clear_emails
    end
end
