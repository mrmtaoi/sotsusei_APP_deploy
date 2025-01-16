import { Application } from "@hotwired/stimulus"

const application = Application.start()

import Rails from "@rails/ujs"
Rails.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
