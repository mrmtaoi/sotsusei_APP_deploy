// app/javascript/application.js
import { Application } from "stimulus"  // stimulusはimportmapでpinしているので、そのまま使う
import { definitionsFromContext } from "stimulus/webpack-helpers"  // Stimulusのwebpack-helpers

import { AutocompleteController } from "./controllers/autocomplete_controller" // 自作のコントローラーをインポート

const application = Application.start()

// コントローラーを登録
application.register("autocomplete", AutocompleteController)

// 他のコントローラーのインポート
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
