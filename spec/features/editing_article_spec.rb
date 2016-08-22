require 'rails_helper'

RSpec.feature "Editing an Article" do
  before do
    @hd = User.create(email: "hd@example.com", password: "password")
    login_as(@hd)
    @article = Article.create(title: "First title Article", body: "Body of article.",user: @hd)
  end
  
  scenario "A user updates an article" do 
    visit '/'

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated titile of article"
    fill_in "Body", with: "Updated body of article"

    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article)) 
  end 

  scenario "A user fail to update an article" do 
    visit '/'

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated body of article"

    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article)) 
  end
end