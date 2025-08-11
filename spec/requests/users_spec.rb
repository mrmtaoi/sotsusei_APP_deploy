# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user1) do
    User.create!(
      name: "ユーザー1",
      email: "user1@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  describe "GET /users/new" do
    before { get new_user_path }

    it "ステータスコードが200になる" do
      expect(response).to have_http_status(:success)
    end

    it "ページに新規ユーザー登録と表示される" do
      expect(response.body).to include("新規ユーザー登録")
    end
  end

  describe "POST /users" do
    it "ユーザー作成に成功して件数が増える" do
      expect do
        post users_path, params: {
          user: {
            name: "新規ユーザー",
            email: "new@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end.to change(User, :count).by(1)
    end

    it "作成後はルートパスにリダイレクトされる" do
      post users_path, params: {
        user: {
          name: "新規ユーザー",
          email: "new@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /users/:id/edit" do
    context "ログイン時" do
      before { login(user1) }

      it "編集ページが表示される" do
        get edit_user_path(user1)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /users/:id" do
    before { login(user1) }

    context "ユーザー名変更" do
      before { patch user_path(user1), params: { user: { name: "更新後のユーザー名" } } }

      it "リダイレクトされる" do
        expect(response).to redirect_to(user_path(user1))
      end

      it "フラッシュが表示される" do
        follow_redirect!
        expect(response.body).to include("ユーザー情報を更新しました")
      end
    end

    context "メールアドレス変更" do
      before { patch user_path(user1), params: { user: { email: "updated@example.com" } } }

      it "リダイレクトされる" do
        expect(response).to redirect_to(user_path(user1))
      end

      it "フラッシュが表示される" do
        follow_redirect!
        expect(response.body).to include("ユーザー情報を更新しました")
      end

      it "メールアドレスが更新される" do
        expect(user1.reload.email).to eq("updated@example.com")
      end
    end

    context "パスワード変更" do
      before do
        patch user_path(user1), params: {
          user: { password: "newpassword", password_confirmation: "newpassword" }
        }
      end

      it "リダイレクトされる" do
        expect(response).to redirect_to(user_path(user1))
      end

      it "フラッシュが表示される" do
        follow_redirect!
        expect(response.body).to include("ユーザー情報を更新しました")
      end

      it "パスワードが更新される" do
        expect(user1.reload.authenticate("newpassword")).to be_truthy
      end
    end

    context "変更失敗" do
      before { patch user_path(user1), params: { user: { email: "" } } }

      it "422エラーになる" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /users/:id" do
    before { login(user1) }

    it "アカウント削除で件数が減る" do
      expect do
        delete user_path(user1)
      end.to change(User, :count).by(-1)
    end

    it "削除後はwelcomeページにリダイレクトされる" do
      delete user_path(user1)
      expect(response).to redirect_to(welcome_path)
    end
  end
end
