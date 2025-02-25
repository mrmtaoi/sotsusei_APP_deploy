import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"; // 修正

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

// Stimulus application のセットアップ
const application = Application.start();

// コントローラの自動読み込み
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
