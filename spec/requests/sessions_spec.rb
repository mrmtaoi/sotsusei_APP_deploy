# spec/requests/sessions_spec.rb
require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    let!(:user) { User.create!(name: "テストユーザー", email: "test@example.com", password: "password", password_confirmation: "password") }
  
    describe "POST /login" do
      context "正しいログイン情報の場合" do
        it "ログインに成功してリダイレクトされる" do
          post login_path, params: { session: { email: user.email, password: 'password' } }
          expect(response).to redirect_to(root_path)  # リダイレクト先の確認
        end
      end
  
      context "誤ったログイン情報の場合" do
        it "ログインに失敗して再描画される" do
          post login_path, params: { session: { email: user.email, password: 'wrongpassword' } }
          expect(response).to render_template(:new)
          expect(response.body).to include("メールアドレスまたはパスワードが間違っています")
        end
      end
  
      context "params[:session]が空の場合" do
        it "不正なリクエストとして処理される" do
          post login_path, params: {}
          expect(response).to render_template(:new)
          expect(response.body).to include("不正なリクエストです")
        end
      end
    end
  
    describe "DELETE /logout" do
      it "ログアウトに成功してリダイレクトされる" do
        post login_path, params: { session: { email: user.email, password: 'password' } }
  
        delete destroy_user_session_path
        expect(response).to redirect_to(login_path)
        follow_redirect!
        expect(response.body).to include("ログアウトしました")
      end
    end
  end
tt  
