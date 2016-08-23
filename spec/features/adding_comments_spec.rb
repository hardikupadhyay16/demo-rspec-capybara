require 'rails_helper'

RSpec.feature "Add reviews to articles" do 
  before do
    @hd = User.create(email: "hd@gmail.com", password: "password")
    @kd = User.create(email: "kd@gmail.com", password: "password")

    @article = Article.create(title: "The first article", body: "Body of first article", user: @hd)
  end

  scenario "Permits a signed in user to write review" do
    login_as(@kd)

    visit '/'
    click_link @article.title
    fill_in "New Comment", with: "An awsome article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An awsome article")
    expect(current_path).to eq(article_path(@article.comments.last.id))
  end
end