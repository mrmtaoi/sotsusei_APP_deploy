// app/javascript/application.js
import { Application } from "stimulus";
import { autoloadControllers } from "stimulus/webpack-helpers"; // 3.0以降のインポート方法

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import "controllers";

// Stimulus applicationのセットアップ
const application = Application.start();

// コントローラの自動読み込み
autoloadControllers(application, "controllers");

