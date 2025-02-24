import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"
import Rails from "@rails/ujs"

Rails.start()

// Stimulus アプリケーションを開始
const application = Application.start()
application.debug = false
window.Stimulus = application

// controllers ディレクトリ内の全ての Stimulus コントローラーを自動登録 (importmap 用)
const context = import.meta.glob("./controllers/**/*.js")
application.load(definitionsFromContext(context))

export { application }
