// app/javascript/application.js
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus"; // 3.0 以降のインポート方法

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

// Stimulus applicationのセットアップ
const application = Application.start();

// コントローラの自動読み込み
const context = require.context("controllers", true, /\.js$/); // コントローラを自動で検索
application.load(definitionsFromContext(context)); // 自動でコントローラを読み込む
