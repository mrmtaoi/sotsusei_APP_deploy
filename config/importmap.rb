# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# Stimulus コントローラーを自動読み込み
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus", to: "stimulus.js", preload: true

