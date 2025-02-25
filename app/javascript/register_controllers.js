function importAll(context) {
    return context.keys().map(context);
  }
  
  export function registerControllers(application) {
    const context = require.context("./controllers", true, /\.js$/);
    importAll(context).forEach((controllerModule) => {
      if (controllerModule.default) {
        const controllerName = controllerModule.default.name.replace("Controller", "").toLowerCase();
        application.register(controllerName, controllerModule.default);
      }
    });
  }
  