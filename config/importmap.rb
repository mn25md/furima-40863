# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "item_price", to: "item_price.js"
pin "payjp", to: "payjp.js" # 修正: 正しいパスに変更
pin "card", to: "packs/card.js"  # 正しいパスを指定
