part of view_model_kit;

typedef ObserveFunction<V> = void Function(V value);

@protected
abstract class BaseR<V> {
  V get value;

  /// observing value changes.
  void observe(ObserveFunction<V> observer) => _observers.add(observer);

  /// cancel observing value changes.
  void cancelObserve(ObserveFunction<V> listener) {
    if (_synchronizeLock) {
      _markedRemoveObservers.add(listener);
    } else {
      _observers.remove(listener);
    }
  }

  /* ----- Private ----- */
  bool _synchronizeLock = false;
  final Set<ObserveFunction<V>> _markedRemoveObservers = {};

  void Function()? get _notifyAtStatefulWidget;

  final Set<ObserveFunction<V>> _observers = {};

  void _notify() {
    if (_enableDefaultNotify) _notifyAtStatefulWidget?.call();

    _synchronizeLock = true;
    for (final observer in _observers) {
      observer.call(value);
    }
    _synchronizeLock = false;
    _markedRemoveObservers.forEach(cancelObserve);
    _markedRemoveObservers.clear();
  }

  void _dispose() {
    _observers.clear();
  }

  /* --- Selector --- */

  int _selectBuilderCount = 0;
  bool _enableDefaultNotify = true;

  void _observeWithSelectBuilder(ObserveFunction<V> observer) {
    observe(observer);
    _selectBuilderCount++;
    _enableDefaultNotify = false;
  }

  void _cancelObserverWithSelectBuilder(ObserveFunction<V> observer) {
    cancelObserve(observer);
    _selectBuilderCount--;
    if (_selectBuilderCount == 0) _enableDefaultNotify = true;
    assert(_selectBuilderCount >= 0);
  }
}
