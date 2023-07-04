part of view_model_kit;

extension CreateReactiveValue on BaseViewModel {
  /// create Reactive Value (int, double, string, model(value object), ...)
  R<V> create<V>(V value) => R._(value).._notify = notify;

  /// create Reactive List
  RList<V> createList<V>(List<V> list) => RList._(list).._notify = notify;
}
