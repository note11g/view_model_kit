part of view_model_kit;

abstract interface class BaseRxCreator {}

extension CreateReactiveValueWithRContainer on BaseRxCreator {
  /// create Reactive Value (int, double, string, model(value object), ...)
  R<V> create<V>(V value) => createMutable<V>(value);

  MutableR<V> createMutable<V>(V value) {
    final rx = MutableR._(value);
    if (this is BaseViewModel) {
      rx._notifyAtStatefulWidget = (this as BaseViewModel).notify;
      (this as BaseViewModel)._addRxDisposer(rx._dispose);
    } else {
      rx._notifyAtStatefulWidget = null;
    }
    return rx;
  }

  /// create Reactive List
  RList<V> createList<V>([List<V>? list]) => createMutableList(list);

  MutableRList<V> createMutableList<V>([List<V>? list]) {
    final rx = MutableRList._(list);
    if (this is BaseViewModel) {
      rx._notifyAtStatefulWidget = (this as BaseViewModel).notify;
      (this as BaseViewModel)._addRxDisposer(rx._dispose);
    } else {
      rx._notifyAtStatefulWidget = null;
    }
    return rx;
  }
}
