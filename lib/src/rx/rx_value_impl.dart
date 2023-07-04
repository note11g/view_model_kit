part of view_model_kit;

/// Reactive Value (int, double, string, model(value object), ...)
class R<V> extends BaseR<V> {
  V _value;

  @override
  late final void Function() _notifyAtStatefulWidget;

  R._(this._value);

  @override
  V get value => _value;

  set value(V newValue) {
    _value = newValue;
    _notify();
  }

  @override
  String toString() => "R($_value)";
}
