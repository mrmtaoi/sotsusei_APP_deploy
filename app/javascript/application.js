import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";  // 必要に応じて

// Turbo
import "@hotwired/turbo-rails";

// Stimulus application のセットアップ
const application = Application.start();

// コントローラーの自動登録
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
