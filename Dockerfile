FROM ruby:3.1.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# 作業ディレクトリを作成
WORKDIR /myapp

# Gemfile と Gemfile.lock を先にコピーして bundle install を実行
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . /myapp

# ポート 3000 を開放
EXPOSE 3000

# デフォルトで rails server を起動
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "$PORT"]
