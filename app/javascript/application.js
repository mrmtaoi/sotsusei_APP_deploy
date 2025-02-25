// app/javascript/application.js
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus"; // `stimulus` から直接インポート

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

// Stimulus applicationのセットアップ
const application = Application.start(); // `Application.start()` で Stimulus アプリケーションを開始

const context = require.context("controllers", true, /\.js$/); // コントローラの自動読み込み
application.load(definitionsFromContext(context)); // コントローラを読み込む
