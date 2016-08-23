require 'rails_helper'
require 'support/macros'
require 'rails-controller-testing'
RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @hd = User.create(email: "hd@example.com", password: "password")
    end

    context "Owner is allowed to edit his articles" do
      it "renders the edit template" do
        login_user @hd
        article = Article.create(title: "Any Title", body: "SOme content", user: @hd)

        get :edit, id: article
        expect(response).to render_template :edit
      end
    end

    context "non-owner is not allowed to edit other users articles" do
      it "redirects to root path" do
        kd = User.create(email: "kd@example.com", password: "password")
        login_user kd

        article = Article.create(title: "Some title", body: "Some content", user: @hd)

        get :edit, id: article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own article."
        expect(flash[:danger]).to eq message
      end
    end
  end

end
