require "rails_helper"

RSpec.feature "Showing an article" do 
  
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
    @kd = User.create(email: "kd@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of article.", user: @hd)
  end

  scenario "A non-signed user does not see edit or delete links" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A non-owner signed in can't see both links" do
    login_as(@kd)
    visit "/"

    click_link @article.title

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A owner can see both links" do
    login_as(@hd)
    visit "/"

    click_link @article.title

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end