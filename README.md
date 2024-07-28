# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

Mac Ruby ローカル環境で、bundle install する際に、Gem エラーが出た場合

```
brew install openssl@1.1
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

echo 'export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"' >> ~/.zshrc
echo 'export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"' >> ~/.zshrc
echo 'export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"' >> ~/.zshrc
source ~/.zshrc

rbenv install 3.0.3
rbenv global 3.0.3


brew install zstd
brew install mysql-client

brew unlink zstd && brew link zstd
export LDFLAGS="-L/opt/homebrew/opt/zstd/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zstd/include"
gem install mysql2 -v 0.5.6 -- --with-mysql-dir=$(brew --prefix mysql-client) --with-opt-dir=$(brew --prefix zstd)
```

- ...

# Todo_tec_karikyuramu_server
