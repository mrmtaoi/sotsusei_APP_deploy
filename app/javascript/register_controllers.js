function importAll(context) {
  return context.keys().map((key) => context(key));
}

export function registerControllers(application) {
  // モジュールのパスを手動でインポートするために、ES Modulesを使用
  const context = import.meta.glob('./controllers/**/*.js');  // この形式はesbuildやViteのようなツールに対応

  // contextは全てのインポートパスを返します
  Object.keys(context).forEach((key) => {
    context[key]().then((controllerModule) => {
      if (controllerModule.default) {
        const controllerName = controllerModule.default.name.replace("Controller", "").toLowerCase();
        application.register(controllerName, controllerModule.default);
      }
    });
  });
}
