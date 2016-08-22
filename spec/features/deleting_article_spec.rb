require 'rails_helper'

RSpec.feature "Deleting an Article" do
  
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
    login_as(@hd)
    @article = Article.create(title: "First title of article", body: "First body of article", user: @hd)
  end

  scenario "A user delete an article" do
    visit '/'

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(page.current_path).to eq(articles_path)
  end
end