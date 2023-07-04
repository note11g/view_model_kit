part of view_model_kit;

abstract class BaseViewModel {
  late final void Function() _notify;

  void notify() => _notify();

  /// must be called 1 time.
  void _setNotify(void Function() notify) {
    _notify = notify;
    onReady();
  }

  /// ViewModel is Ready, onReady will called.
  void onReady() {}
}
