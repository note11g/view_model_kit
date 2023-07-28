part of view_model_kit;

/// Reactive List. (immutable, read only)
abstract interface class RList<V> extends BaseR<List<V>> {
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

  V get first => _list.first;

  V get last => _list.last;

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => "RList($_list)";

  MutableRList<V> toMutableList() => this as MutableRList<V>;
}

/// Reactive List. (mutable, read/write)
final class MutableRList<V> extends RList<V> with ListBase<V> {
  MutableRList._([List<V>? list]) : super._(list);

  /// Write
  ///
  @override
  void operator []=(int index, V value) {
    _list[index] = value;
    _notify();
  }

  @override
  void add(V element) {
    _list.add(element);
    _notify();
  }

  @override
  void addAll(Iterable<V> iterable) {
    _list.addAll(iterable);
    _notify();
  }

  @override
  void insert(int index, V element) {
    _list.insert(index, element);
    _notify();
  }

  @override
  void insertAll(int index, Iterable<V> iterable) {
    _list.insertAll(index, iterable);
    _notify();
  }

  @override
  bool remove(Object? element) {
    final res = _list.remove(value);
    _notify();
    return res;
  }

  @override
  V removeLast() {
    final v = _list.removeLast();
    _notify();
    return v;
  }

  @override
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
  set length(int newLength) {
    _list.length = newLength;
    _notify();
  }

  @override
  void sort([int Function(V a, V b)? compare]) {
    _list.sort(compare);
    _notify();
  }

  @override
  void shuffle([Random? random]) {
    _list.shuffle(random);
    _notify();
  }

  @override
  void setAll(int index, Iterable<V> iterable) {
    _list.setAll(index, iterable);
    _notify();
  }

  @override
  void removeWhere(bool Function(V element) test) {
    _list.removeWhere(test);
    _notify();
  }

  @override
  V removeAt(int index) {
    final res = _list.removeAt(index);
    _notify();
    return res;
  }

  @override
  void retainWhere(bool Function(V element) test) {
    _list.retainWhere(test);
    _notify();
  }

  @override
  void fillRange(int start, int end, [V? fill]) {
    _list.fillRange(start, end, fill);
    _notify();
  }

  @override
  void replaceRange(int start, int end, Iterable<V> newContents) {
    _list.replaceRange(start, end, newContents);
    _notify();
  }

  @override
  void setRange(int start, int end, Iterable<V> iterable, [int skipCount = 0]) {
    _list.setRange(start, end, iterable, skipCount);
    _notify();
  }

  @override
  void removeRange(int start, int end) {
    _list.removeRange(start, end);
    _notify();
  }
}
