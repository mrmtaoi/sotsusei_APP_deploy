import { Application } from "@hotwired/stimulus";

// Turbo
import "@hotwired/turbo-rails";

// Stimulus controllers
import { registerControllers } from "./register_controllers"; // 手動登録用のスクリプトをインポート

// Stimulus application のセットアップ
const application = Application.start();

// コントローラの登録を実行
registerControllers(application);
