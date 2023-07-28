import 'package:view_model_kit/view_model_kit.dart';

class MainViewModel extends BaseViewModel {
  late final _counter = createMutable(0);
  R<int> get counter => _counter;
  late final _counter2 = createMutable(0);
  R<int> get counter2 => _counter2;

  late final _resultList = createMutableList<int>();
  RList<int> get resultList => _resultList;

  void incrementCounter() {
    _counter.value++;
    _resultList.add(_counter.value);
  }

  void decreaseCounter2() {
    _counter2.value--;
    _resultList.value.add(_counter2.value);

    /// using rxList.value prevent rebuild.
  }

  @override
  void onReady() {
    print("onReady");
    super.onReady();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }
}
