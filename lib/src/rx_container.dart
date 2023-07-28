part of view_model_kit;

abstract class BaseContainer implements BaseRxCreator {
  BaseContainer() {
    onCreate();
  }

  void onCreate() {}
}
