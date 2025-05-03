require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user1) { User.create!(name: "ユーザー1", email: "user1@example.com", password: "password", password_confirmation: "password") }
  let!(:user2) { User.create!(name: "ユーザー2", email: "user2@example.com", password: "password", password_confirmation: "password") }

  describe "GET /users/new" do
    it "新規登録ページ表示" do
      get new_user_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("新規登録")
    end
  end

  describe "POST /users" do
    it "ユーザー作成に成功" do
      expect {
        post users_path, params: {
          user: {
            name: "新規ユーザー",
            email: "new@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      }.to change(User, :count).by(1)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /users/:id/edit" do
    context "ユーザー１" do
      before { post login_path, params: { session: { email: user1.email, password: 'password' } } }

      it "ユーザー情報編集ページが表示される" do
        get edit_user_path(user1)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /users/:id" do
    before { post login_path, params: { session: { email: user1.email, password: 'password' } } }

    it "ユーザー名変更" do
      patch user_path(user1), params: { user: { name: "更新後のユーザー名" } }
      expect(response).to redirect_to(user_path(user1))
      follow_redirect!
      expect(response.body).to include("ユーザー情報を更新しました")
    end

    it "メールアドレス変更" do
      patch user_path(user1), params: {
        user: { email: "updated@example.com" }
      }
      expect(response).to redirect_to(user_path(user1))
      follow_redirect!
      expect(response.body).to include("ユーザー情報を更新しました")
      expect(user1.reload.email).to eq("updated@example.com")
    end

    it "パスワード変更" do
      patch user_path(user1), params: {
        user: {
          password: "newpassword",
          password_confirmation: "newpassword"
        }
      }
      expect(response).to redirect_to(user_path(user1))
      follow_redirect!
      expect(response.body).to include("ユーザー情報を更新しました")
      expect(user1.reload.authenticate("newpassword")).to be_truthy
    end

    it "変更失敗" do
      patch user_path(user1), params: { user: { email: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /users/:id" do
    before { post login_path, params: { session: { email: user1.email, password: 'password' } } }

    it "アカウント削除" do
      expect {
        delete user_path(user1)
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to(welcome_path)
    end
  end
end
