# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "bootstrap" # @5.3.0
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

