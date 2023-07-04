import 'package:view_model_kit/view_model_kit.dart';

class MainViewModel extends BaseViewModel {
  late final counter = create(0);

  void incrementCounter() {
    counter.value++;
  }
}
