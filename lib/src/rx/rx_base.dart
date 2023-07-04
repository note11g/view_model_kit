part of view_model_kit;

@protected
abstract class BaseR<V> {
  V get value;

  /// observing value changes.
  void observe(void Function() observer) => _observers.add(observer);

  /// cancel observing value changes.
  void cancelObserve(void Function() listener) {
    _observers.remove(listener);
  }

  /* ----- Private ----- */

  void Function() get _notifyAtStatefulWidget;

  final List<void Function()> _observers = [];

  void _notify() {
    if (_enableDefaultNotify) _notifyAtStatefulWidget();
    for (final observer in _observers) {
      observer.call();
    }
  }

  void _dispose() {
    _observers.clear();
  }

  /* --- Selector --- */

  int _selectBuilderCount = 0;
  bool _enableDefaultNotify = true;

  void _observeWithSelectBuilder(void Function() observer) {
    observe(observer);
    _selectBuilderCount++;
    _enableDefaultNotify = false;
  }

  void _cancelObserverWithSelectBuilder(void Function() observer) {
    cancelObserve(observer);
    _selectBuilderCount--;
    if (_selectBuilderCount == 0) _enableDefaultNotify = true;
    assert(_selectBuilderCount >= 0);
  }
}
