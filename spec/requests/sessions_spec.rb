# spec/requests/sessions_spec.rb
require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) do
    User.create!(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  describe "POST /login" do
    context "正しいログイン情報" do
      before { post login_path, params: { session: { email: user.email, password: 'password' } } }

      it "ルートパスにリダイレクトされる" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "誤ったログイン情報" do
      before { post login_path, params: { session: { email: user.email, password: 'wrongpassword' } } }

      it "newテンプレートが再描画される" do
        expect(response).to render_template(:new)
      end

      it "エラーメッセージが表示される" do
        expect(response.body).to include("メールアドレスまたはパスワードが間違っています")
      end
    end

    context "params[:session] が空" do
      before { post login_path, params: {} }

      it "newテンプレートが再描画される" do
        expect(response).to render_template(:new)
      end

      it "エラーメッセージが表示される" do
        expect(response.body).to include("不正なリクエストです")
      end
    end
  end

  describe "DELETE /logout" do
    before do
      post login_path, params: { session: { email: user.email, password: 'passwor_
