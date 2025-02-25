// app/javascript/application.js
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus";
import { start } from "stimulus";

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

// Stimulus applicationのセットアップ
const application = Application.start();