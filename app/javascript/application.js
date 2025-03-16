import { Application } from "@hotwired/stimulus"
import AutocompleteController from "./autocomplete_controller"  // 独自のコントローラーをインポート

const application = Application.start()
application.register("autocomplete", AutocompleteController)  // 自作のAutocompleteControllerを登録

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
