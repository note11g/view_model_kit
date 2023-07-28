part of view_model_kit;

/// Reactive Value (int, double, string, model(value object), ...)
///
/// (immutable, read only)
abstract interface class R<V> extends BaseR<V> {
  V _value;

  @override
  late final void Function()? _notifyAtStatefulWidget;

  R._(this._value);

  @override
  V get value => _value;

  @override
  String toString() => "R($_value)";

  MutableR<V> toMutable() => this as MutableR<V>;
}

/// Reactive Value (int, double, string, model(value object), ...)
///
/// (mutable, read/write)
final class MutableR<V> extends R<V> {
  MutableR._(V value) : super._(value);

  set value(V newValue) {
    _value = newValue;
    _notify();
  }
}
