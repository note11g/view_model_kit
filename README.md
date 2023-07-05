# view_model_kit

[![pub package](https://img.shields.io/pub/v/view_model_kit.svg?color=4285F4)](https://pub.dev/packages/view_model_kit)

A simple and easy ViewModel and state management Library.

## How to use

see examples.
[main_page.dart](https://github.com/note11g/view_model_kit/blob/main/example/lib/main_page.dart)
[main_view_model.dart](https://github.com/note11g/view_model_kit/blob/main/example/lib/main_view_model.dart)

### 1. Setting StatefulWidget and Create ViewModel

`main_page.dart`

```dart
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends StateWithViewModel<MainPage, MainViewModel> {
  @override
  MainViewModel createViewModel() => MainViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

`main_view_model.dart`

```dart
class MainViewModel extends BaseViewModel {
  @override
  void onReady() {
    // onReady called only once when the ViewModel is ready. (first build)
  }
}
```

### 2. Use R<V> or RList<V> with ViewModel

```dart
class MainViewModel extends BaseViewModel {
  late final count = create(0);
  late final todos = createList<Todo>([]);

  @override
  void onReady() async {
    count.value = 1; // auto rebuild.
    count.value++; // auto rebuild.

    final todos = await getTodosFromRemote();

    todos.addAll([...todos]); // auto rebuild.
    //but...
    print(todos.value); // ok
    print(todos.value.addAll([...todos])); // not rebuild. use instead of todos.addAll([...todos]);
  }
}
```

### 3. Use R<V> or RList<V> with Widget

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(chlidren: [
        Text("${viewModel.count.value}"),
        Text("${viewModel.todos.value}"),
      ]),
    ),
  );
}
```

### 4. Minimal rebuild

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(chlidren: [
        SelectBuilder(
          rx: viewModel.count,
          builder: (context, count) =>
              Text("$count (rebuild only this widget)"), // rebuild only (when updated)
        ),
        Text("${viewModel.count.value} (not rebuild)"),
      ]),
    ),
  );
}
```

### 5. Global State Manage Container

in this example, use [GetIt](https://pub.dev/packages/get_it).

```main_container.dart```

```dart
class MainContainer extends BaseContainer {
  late final globalCount = create(0);
}
```

```main.dart```

```dart
void main() {
  GetIt.instance.registerLazySingleton(() => MainContainer());
  // or, registerLazySingleton(MainContainer.new);
  runApp(MyApp());
}
```

```counter1_page.dart```

```dart
class Counter1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = GetIt.instance<MainContainer>();
    return Scaffold(
      body: Center(child:
      ElevatedButton(
          child: Text("Page1 count up : ${container.globalCount.value}"),
          onPressed: () => container.globalCount.value++),
      ),
    );
  }
}
```

```counter2_page.dart```

```dart
class Counter2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = GetIt.instance<MainContainer>();
    return Scaffold(
      body: Center(child: ElevatedButton(
          child: Text("Page2 count up : ${container.globalCount.value}"),
          onPressed: () => container.globalCount.value++),
      ),
    );
  }
}
```