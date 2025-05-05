# spec/support/login_helper.rb
module LoginHelper
  def login(user)
    post login_path, params: { session: { email: user.email, password: user.password } }
    follow_redirect! if response.redirect?
  end
end
