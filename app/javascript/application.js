// app/javascript/application.js
import { start } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import { Application } from "stimulus";

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
import "controllers"
