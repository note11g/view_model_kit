part of view_model_kit;

extension CreateReactiveValueWithViewModel on BaseViewModel {
  /// create Reactive Value (int, double, string, model(value object), ...)
  R<V> create<V>(V value) {
    final rx = R._(value);
    rx._notifyAtStatefulWidget = notify;
    _addRxDisposer(rx._dispose);
    return rx;
  }

  /// create Reactive List
  RList<V> createList<V>([List<V>? list]) {
    final rx = RList._(list);
    rx._notifyAtStatefulWidget = notify;
    _addRxDisposer(rx._dispose);
    return rx;
  }
}

extension CreateReactiveValueWithRContainer on BaseContainer {
  /// create Reactive Value (int, double, string, model(value object), ...)
  R<V> create<V>(V value) {
    final rx = R._(value);
    rx._notifyAtStatefulWidget = null;
    return rx;
  }

  /// create Reactive List
  RList<V> createList<V>([List<V>? list]) {
    final rx = RList._(list);
    rx._notifyAtStatefulWidget = null;
    return rx;
  }
}
