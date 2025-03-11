// register_controllers.js
import { application } from "controllers/application"; // Stimulus アプリケーションをインポート

// 各コントローラーを手動でインポートして登録
import { CategoryController } from "controllers/category_controller";
application.register("category", CategoryController);

// 必要に応じて他のコントローラーもインポートして登録
// import { AnotherController } from "controllers/another_controller";
// application.register("another", AnotherController);
