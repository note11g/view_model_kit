import 'package:view_model_kit/view_model_kit.dart';

class MainViewModel extends BaseViewModel {
  late final counter = create(0);
  late final counter2 = create(0);

  void incrementCounter() {
    counter.value++;
  }

  void decreaseCounter2() {
    counter2.value--;
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
