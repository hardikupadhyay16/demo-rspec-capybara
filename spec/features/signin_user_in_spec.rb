require 'rails_helper'

RSpec.feature "Users sign-in" do
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit '/'

    click_link "Sign in"
    fill_in "Email", with: @hd.email
    fill_in "Password", with: @hd.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@hd.email}")
  end
end