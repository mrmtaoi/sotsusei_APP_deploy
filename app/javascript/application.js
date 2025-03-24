// app/assets/javascripts/application.js

import { Application } from "@hotwired/stimulus"
import AutocompleteController from "./controllers/autocomplete_controller" // パスを確認

const application = Application.start()
application.register("autocomplete", AutocompleteController)

window.Stimulus = application

export { application }
