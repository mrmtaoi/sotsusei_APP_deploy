// app/assets/javascripts/application.js
//= require jquery3
//= require popper
//= require bootstrap

import "bootstrap"
import $ from "jquery";
window.$ = $;

import { Application } from "@hotwired/stimulus"
import AutocompleteController from "./controllers/autocomplete_controller" // パスを確認

const application = Application.start()
application.register("autocomplete", AutocompleteController)

window.Stimulus = application

export { application }
