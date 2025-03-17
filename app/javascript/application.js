// app/javascript/application.js
import { Application } from "stimulus"  // stimulusはimportmapでpinしているので、そのまま使う
import { AutocompleteController } from "./controllers/autocomplete_controller" // 自作のコントローラーをインポート

const application = Application.start()

// コントローラーを登録
application.register("autocomplete", AutocompleteController)

// 他のコントローラーの自動登録
const context = require.context("./controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
