part of view_model_kit;

abstract class _BaseR {
  void Function() get _notify;
}

/// Reactive Value (int, double, string, model(value object), ...)
class R<V> implements _BaseR {
  V _value;

  @override
  late final void Function() _notify;

  R._(this._value);

  V get value => _value;

  set value(V newValue) {
    _value = newValue;
    _notify();
  }

  @override
  String toString() => "R($_value)";
}

/// Reactive List
class RList<V> implements _BaseR {
  final List<V> _list;

  @override
  late final void Function() _notify;

  RList._(this._list);

  /// Read

  List<V> get value => _list;

  V operator [](int index) => _list[index];

  int get length => _list.length;

  /// Write

  void operator []=(int index, V value) {
    _list[index] = value;
    _notify();
  }

  void add(V value) {
    _list.add(value);
    _notify();
  }

  void addAll(Iterable<V> iterable) {
    _list.addAll(iterable);
    _notify();
  }

  void remove(V value) {
    _list.remove(value);
    _notify();
  }

  void clear() {
    _list.clear();
    _notify();
  }

  void change(List<V> newList) {
    _list.clear();
    _list.addAll(newList);
    _notify();
  }

  @override
  String toString() => "RList($_list)";
}
