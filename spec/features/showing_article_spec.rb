require "rails_helper"

RSpec.feature "Showing an article" do 
  
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
    login_as(@hd)
    @article = Article.create(title: "The first article", body: "Body of article.", user: @hd)
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end