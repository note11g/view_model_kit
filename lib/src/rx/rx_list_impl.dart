part of view_model_kit;

/// Reactive List
class RList<V> extends BaseR<List<V>> {
  final List<V> _list;

  @override
  late final void Function()? _notifyAtStatefulWidget;

  RList._([List<V>? list]) : _list = list ?? [];

  /// Read

  /// do not write with this list.
  @override
  List<V> get value => _list;

  V operator [](int index) => _list[index];

  int get length => _list.length;

  /// Write
  ///
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

  void insert(int index, V element) {
    _list.insert(index, element);
    _notify();
  }

  void insertAll(int index, Iterable<V> iterable) {
    _list.insertAll(index, iterable);
    _notify();
  }

  bool remove(Object? value) {
    final res = _list.remove(value);
    _notify();
    return res;
  }

  V removeLast() {
    final v = _list.removeLast();
    _notify();
    return v;
  }

  void clear() {
    _list.clear();
    _notify();
  }

  /// clear and addAll to List
  void change(List<V> newList) {
    _list.clear();
    _list.addAll(newList);
    _notify();
  }

  @override
  String toString() => "RList($_list)";
}
