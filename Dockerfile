FROM ruby:3.1.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs curl

# Node.js を最新バージョンに更新
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Yarn のインストール
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn

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
CMD ["sh", "-c", "rails server -b '0.0.0.0' -p $PORT"]
