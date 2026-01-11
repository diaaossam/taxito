enum AppFlavor { user, driver }

class FlavorConfig {
  final AppFlavor flavor;

  static late FlavorConfig _instance;

  FlavorConfig._internal(this.flavor);

  static void initialize(AppFlavor flavor) {
    _instance = FlavorConfig._internal(flavor);
  }

  static AppFlavor get currentFlavor => _instance.flavor;
}
