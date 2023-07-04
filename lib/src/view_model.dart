part of view_model_kit;

abstract class BaseViewModel {
  /// Notify to Stateful Widget.
  void notify() => _notifyAtStatefulWidget();

  /// ViewModel is Ready, onReady will called.
  void onReady() {}

  /// ViewModel is disposed, dispose will called.
  void dispose() {
    for (final rxDispose in _rxDisposers) {
      rxDispose();
    }
    _rxDisposers.clear();
  }

  /* ----- Private ----- */

  late final void Function() _notifyAtStatefulWidget;

  /// must be called 1 time.
  void _setNotifyAtStatefulWidget(void Function() notifier) {
    _notifyAtStatefulWidget = notifier;
    onReady();
  }

  final List<void Function()> _rxDisposers = [];

  void _addRxDisposer(void Function() dispose) => _rxDisposers.add(dispose);
}
