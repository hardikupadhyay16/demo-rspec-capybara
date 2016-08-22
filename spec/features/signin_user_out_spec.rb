require 'rails_helper'

RSpec.feature "Signing out signed-in users" do
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
    visit '/'

    click_link "Sign in"
    fill_in "Email", with: @hd.email
    fill_in "Password", with: @hd.password
    click_button "Log in"
  end

  scenario do
    visit '/'
    click_link 'Sign out'
    expect(page).to have_content("Signed out successfully.")
  end
end