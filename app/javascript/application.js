// app/javascript/application.js
import { Application } from "stimulus";
import { defineModulesFromContext } from "stimulus";

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

// Stimulus applicationのセットアップ
const application = Application.start();

// コントローラの自動読み込み
const context = require.context("controllers", true, /\.js$/);
application.load(defineModulesFromContext(context));
