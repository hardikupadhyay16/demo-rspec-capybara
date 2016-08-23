require "rails_helper"

RSpec.feature "Listing Articles" do
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
    @article1 = Article.create(title: "The first article", body: "Body of first Article", user: @hd)
    @article2 = Article.create(title: "The second article", body: "Body of second Article", user: @hd)
  end

  scenario "List all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end
end